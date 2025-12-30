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
const submit = (id, data) => {
  return http.post(`/api/quizzes/${id}/submit`, data);
};

const QuizService = {
  getAll,
  getById,
  submit,
};

export default QuizService;