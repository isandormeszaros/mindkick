import { Router } from "express";
import db from '../config/dboperations.js';
import { authenticateToken, isAdmin } from '../middlewares/authMiddleware.js';
const router = Router();

// GET /allquiz
router.get("/", (req, res) => {
  db.getQuizzes()
    .then((data) => res.json(data))
    .catch((error) => res.status(500).send(error));
});

router.get("/:id", (req, res) => {
  let id = req.params.id;
  db.getQuizById(id)
    .then((data) => {
      if (!data) res.status(404).send("Not found");
      else res.json(data);
    })
    .catch((error) => res.status(500).send(error));
});

router.post("/:id/submit", (req, res) => {
  let quizId = req.params.id;
  let { userId, answers } = req.body;

  if (!answers || !answers.length) {
    return res.status(400).send("No answers provided");
  }

  db.submitQuiz(quizId, userId, answers)
    .then((data) => res.json(data))
    .catch((error) => res.status(500).send(error));
});

// ADMIN ÚTVONAL 
router.post("/create", 
  authenticateToken, 
  isAdmin, 
  async (req, res) => {
    try {
      const userId = req.user.id;
      
      const quizData = {
        ...req.body,
        userId: userId 
      };

      if (!quizData.title || !quizData.questions || quizData.questions.length === 0) {
        return res.status(400).json({ error: "Hiányzó adatok: Cím és kérdések kötelezőek!" });
      }

      const result = await db.createFullQuiz(quizData);
      
      res.status(201).json(result);

    } catch (error) {
      console.error("Kvíz mentési hiba:", error);
      res.status(500).json({ error: "Szerver hiba a kvíz mentésekor." });
    }
  }
);

export default router;
