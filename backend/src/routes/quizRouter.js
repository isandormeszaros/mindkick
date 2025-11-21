import { Router } from "express";

const router = Router();
import { getQuizController } from "../controllers/quizController.js";

// GET /allquiz
router.get("/all", getQuizController)

export default router;