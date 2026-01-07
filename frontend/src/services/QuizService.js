import http from "../../http-common";

// GET ALL QUIZZES
const getAll = (search = "", category = "") => {
  return http.get(`/quiz?search=${search}&category=${category}`);
};

// GET QUIZ BY ID
const getById = (id) => {
  return http.get(`/quiz/${id}`);
};

// SUBMIT QUIZ
const submit = (id, data) => {
  return http.post(`/quiz/${id}/submit`, data);
};

const QuizService = {
  getAll,
  getById,
  submit,
};

export default QuizService;