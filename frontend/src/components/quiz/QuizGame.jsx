import { useEffect, useState } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import QuizService from "../../services/QuizService";
import QuizPlayArea from "./QuizPlayArea";
import QuizResult from "./QuizResult";

const QuizGame = () => {
  const { id } = useParams();
  const navigate = useNavigate();

  const [loading, setLoading] = useState(true);
  const [quizData, setQuizData] = useState(null);
  const [questions, setQuestions] = useState([]);
  const [currentIndex, setCurrentIndex] = useState(0);
  const [userAnswers, setUserAnswers] = useState([]);
  const [result, setResult] = useState(null);
  const [timeLeft, setTimeLeft] = useState(0);

  const STORAGE_KEY = `quiz_game_state_${id}`;

  const getTimeByDifficulty = (difficulty) => {
    switch (difficulty) {
      case 'easy': return 10;
      case 'medium': return 20;
      case 'hard': return 30;
      default: return 15;
    }
  };

  useEffect(() => {
    setLoading(true);
    setResult(null);
    const savedState = localStorage.getItem(STORAGE_KEY);

    if (savedState) {
      try {
        const parsed = JSON.parse(savedState);
        setQuizData(parsed.quizData);
        setQuestions(parsed.questions);
        setCurrentIndex(parsed.currentIndex);
        setUserAnswers(parsed.userAnswers);
        setTimeLeft(parsed.timeLeft);
        setLoading(false);
      } catch (e) {
        localStorage.removeItem(STORAGE_KEY);
        resetAndFetch();
      }
    } else {
      resetAndFetch();
    }
  }, [id]);

  const resetAndFetch = () => {
    setQuizData(null);
    setCurrentIndex(0);
    setUserAnswers([]);
    setQuestions([]);
    setTimeLeft(0);
    getQuiz(id);
  };

  useEffect(() => {
    const isConsistent = quizData && String(quizData.id) === String(id);

    if (!loading && !result && questions.length > 0 && isConsistent) {
      const stateToSave = { quizData, questions, currentIndex, userAnswers, timeLeft };
      localStorage.setItem(STORAGE_KEY, JSON.stringify(stateToSave));
    }
  }, [loading, result, questions, quizData, currentIndex, userAnswers, timeLeft, STORAGE_KEY]);

  const getQuiz = (id) => {
    QuizService.getById(id)
      .then(response => {
        setQuizData(response.data.info);
        setTimeLeft(getTimeByDifficulty(response.data.info.difficulty));
        
        const q = [...response.data.questions];
        for (let i = q.length - 1; i > 0; i--) {
          const j = Math.floor(Math.random() * (i + 1));
          [q[i], q[j]] = [q[j], q[i]];
        }
        setQuestions(q);
        setLoading(false);
      })
      .catch(e => { console.log(e); setLoading(false); });
  };

  const handleAnswer = (optionId) => {
    const currentQ = questions[currentIndex];
    if (!currentQ) return;

    const newAnswer = { questionId: currentQ.id, selectedOptionId: optionId };
    const updatedAnswers = [...userAnswers, newAnswer];
    setUserAnswers(updatedAnswers);

    if (currentIndex < questions.length - 1) {
      setCurrentIndex(currentIndex + 1);
      setTimeLeft(getTimeByDifficulty(quizData.difficulty));
    } else {
      submitQuiz(updatedAnswers);
    }
  };

  const handleTimeout = () => {
    handleAnswer(null);
  };

  const submitQuiz = (finalAnswers) => {
    const data = { userId: 1, answers: finalAnswers };
    QuizService.submit(id, data)
      .then(response => {
        setResult(response.data);
        localStorage.removeItem(STORAGE_KEY);
      })
      .catch(e => console.log(e));
  };

  useEffect(() => {
    if (!loading && !result && timeLeft > 0) {
      const timerId = setInterval(() => setTimeLeft((t) => t - 1), 1000);
      return () => clearInterval(timerId);
    }
    if (timeLeft === 0 && !result && !loading && questions.length > 0) {
      handleTimeout();
    }
  }, [timeLeft, loading, result, questions]);

  if (loading) return <div className="text-center mt-20 text-xl font-medium text-gray-500">Betöltés...</div>;
  if (!quizData) return <div className="text-center mt-20">Hiba az adatok betöltésekor.</div>;

  if (result) {
    return (
      <QuizResult 
        result={result}
        questions={questions}
        userAnswers={userAnswers}
        onRetry={() => navigate('/')}
        onNavigateNext={(newId) => {
           navigate(`/quiz/${newId}`);
        }}
      />
    );
  }

  return (
    <QuizPlayArea 
      quizTitle={quizData.title}
      difficulty={quizData.difficulty}
      question={questions[currentIndex]}
      currentIndex={currentIndex}
      totalQuestions={questions.length}
      timeLeft={timeLeft}
      onAnswer={handleAnswer}
    />
  );
};

export default QuizGame;