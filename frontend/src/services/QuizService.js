import http from "../../http-common";

// GET ALL QUIZZES
const getAll = () => {
  return http.get("/quiz/");
};

// GET QUIZ BY ID
const getById = (id) => {
  return http.get(`/quiz/${id}`);
};

// SUBMIT QUIZ
const submit = (id, data, config) => {
  return http.post(`/quiz/${id}/submit`, data, config);
};

const getLeaderboard = () => {
  return http.get(`/quiz/leaderboard`);
};

const QuizService = {
  getAll,
  getById,
  submit,
  getLeaderboard
};

export default QuizService;