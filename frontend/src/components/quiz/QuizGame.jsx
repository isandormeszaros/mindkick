import { useEffect, useState } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import QuizService from "../../services/QuizService";

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

  const getTimeByDifficulty = (difficulty) => {
    switch (difficulty) {
      case 'easy': return 10;
      case 'medium': return 20;
      case 'hard': return 30;
      default: return 15;
    }
  };

  useEffect(() => {
    getQuiz(id);
  }, [id]);

  useEffect(() => {
    if (quizData) {
      const time = getTimeByDifficulty(quizData.difficulty);
      setTimeLeft(time);
    }
  }, [currentIndex, quizData]);

  const getQuiz = (id) => {
    QuizService.getById(id)
      .then(response => {
        setQuizData(response.data.info);

        const initialTime = getTimeByDifficulty(response.data.info.difficulty);
        setTimeLeft(initialTime);

        const q = [...response.data.questions];
        for (let i = q.length - 1; i > 0; i--) {
          const j = Math.floor(Math.random() * (i + 1));
          [q[i], q[j]] = [q[j], q[i]];
        }

        setQuestions(q);
        setLoading(false);
      })
      .catch(e => {
        console.log(e);
      });
  };

  const handleAnswer = (optionId) => {
    const currentQ = questions[currentIndex];
    if (!currentQ) return;
    const newAnswer = {
      questionId: currentQ.id,
      selectedOptionId: optionId
    };

    const updatedAnswers = [...userAnswers, newAnswer];
    setUserAnswers(updatedAnswers);

    if (currentIndex < questions.length - 1) {
      setCurrentIndex(currentIndex + 1);
    } else {
      submitQuiz(updatedAnswers);
    }
  };

  const submitQuiz = (finalAnswers) => {
    const data = {
      userId: 1,
      answers: finalAnswers
    };

    QuizService.submit(id, data)
      .then(response => {
        setResult(response.data);
      })
      .catch(e => {
        console.log(e);
      });
  };

  useEffect(() => {
    if (!loading && !result && timeLeft > 0) {
      const timerId = setInterval(() => {
        setTimeLeft((prevTime) => prevTime - 1);
      }, 1000);
      return () => clearInterval(timerId);
    }

    if (timeLeft === 0 && !result) {
      handleTimeout();
    }
  }, [timeLeft, loading, result]);

  const handleTimeout = () => {
    handleAnswer(null);
  };

  const formatTime = (seconds) => {
    const minutes = Math.floor(seconds / 60);
    const secs = seconds % 60;
    return `${minutes}:${secs < 10 ? '0' : ''}${secs}`;
  };


  if (loading) return <div className="text-center mt-20 text-xl font-medium text-gray-500">Betöltés...</div>;

  if (result) {
    return (
      <div className="max-w-md mx-auto bg-white p-10 rounded-3xl shadow-lg text-center mt-10">
        <h2 className="text-3xl font-bold mb-4 text-gray-800">Eredmény</h2>

        <div className="relative w-40 h-40 mx-auto flex items-center justify-center rounded-full border-8 border-blue-100 mb-6">
          <span className="text-4xl font-black text-blue-600">{result.percentage}%</span>
        </div>

        <p className="text-lg text-gray-600 mb-8">
          <span className="font-bold text-gray-900">{result.score}</span> helyes válasz a <span className="font-bold text-gray-900">{result.total}</span> kérdésből.
        </p>

        <button
          onClick={() => navigate('/')}
          className="w-full bg-gray-900 text-white py-3 rounded-xl font-medium hover:bg-gray-800 transition"
        >
          Vissza a főoldalra
        </button>
      </div>
    );
  }

  const currentQ = questions[currentIndex];
  if (!currentQ) {
    return <div className="text-center mt-20 text-white">Hiba: A kérdés nem található.</div>;
  }
  const progress = ((currentIndex + 1) / questions.length) * 100;

  return (
    <div className="max-w-2xl mx-auto mt-8">
      <div className="mb-8">
        <div className="flex justify-between items-center mb-2">
          <h2 className="text-3xl font-bold text-gray-900">{quizData?.title}</h2>
          <span className="px-3 py-1 bg-gray-200 rounded-full text-xs font-bold uppercase text-gray-600">
            {quizData?.difficulty}
          </span>
        </div>
        <div className="w-full bg-gray-200 rounded-full h-3 mt-4 overflow-hidden">
          <div
            className="bg-blue-600 h-3 rounded-full transition-all duration-500 ease-out"
            style={{ width: `${progress}%` }}
          ></div>
        </div>

        <div className="flex justify-between items-center mt-2">
          <span className="text-gray-500 font-medium">{currentIndex + 1} / {questions.length}</span>

          <div className={`text-xl font-bold ${timeLeft < 10 ? 'text-red-500 animate-pulse' : 'text-blue-600'}`}>
            {formatTime(timeLeft)}
          </div>
        </div>

        <div className="text-right text-sm text-gray-500 mt-2 font-medium">
        </div>
      </div>

      <div className="bg-white p-8 rounded-2xl shadow-lg border border-gray-100">
        <h3 className="text-xl font-semibold mb-8 text-gray-800 leading-relaxed">
          {currentQ?.text}
        </h3>

        <div className="space-y-4">
          {currentQ?.options.map((opt) => (
            <button
              key={opt.id}
              onClick={() => handleAnswer(opt.id)}
              className="w-full text-left p-5 border-2 border-gray-100 rounded-xl hover:border-blue-500 hover:bg-blue-50 transition duration-200 font-medium text-gray-700 active:scale-[0.98]"
            >
              {opt.text}
            </button>
          ))}
        </div>
      </div>
    </div>
  );
};

export default QuizGame;