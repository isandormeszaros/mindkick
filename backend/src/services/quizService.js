import { getQuiz } from "../config/dboperations.js";

export const getQuizService = () => {
  return getQuiz();
};