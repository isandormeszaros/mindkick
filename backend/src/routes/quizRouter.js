import { Router } from "express";

const router = Router();
import  getQuiz  from "../config/dboperations.js";

// GET /allquiz
router.get("/all", async (req, res) => {
  try {
    const data = await getQuiz();
    res.status(200).json(data);
  } catch (error) {
    console.error("Error fetching quiz:", error);
    res.status(500).json({ error: "Server error retrieving quiz data" });
  }
});

export default router;