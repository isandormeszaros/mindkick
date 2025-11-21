import { getQuizService } from "../services/quizService.js";

export const getQuizController = async (req, res) => {
  try {
    const data = await getQuizService();
    res.status(200).json(data);
  } catch (err) {
    console.error("Controller error:", err);
    res.status(500).json({ error: "Internal Server Error" });
  }
};