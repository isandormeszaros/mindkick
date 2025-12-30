import { Router } from "express";
import db from '../config/dboperations.js';
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

export default router;
