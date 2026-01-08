import { useState } from 'react';
import { useNavigate } from 'react-router-dom';

export const useCreateQuiz = () => {
  const navigate = useNavigate();
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);

  const [quizData, setQuizData] = useState({
    title: '', description: '', category_id: 1, difficulty: 'easy'
  });

  const [questions, setQuestions] = useState([{
      text: '',
      options: [
        { text: '', isCorrect: true }, { text: '', isCorrect: false },
        { text: '', isCorrect: false }, { text: '', isCorrect: false }
      ]
  }]);

  const handleQuizChange = (e) => {
    const { name, value } = e.target;
    setQuizData({ ...quizData, [name]: name === 'category_id' ? parseInt(value) : value });
  };

  const handleQuestionChange = (index, value) => {
    const newQ = [...questions]; newQ[index].text = value; setQuestions(newQ);
  };

  const handleOptionChange = (qIndex, oIndex, value) => {
    const newQ = [...questions]; newQ[qIndex].options[oIndex].text = value; setQuestions(newQ);
  };

  const setCorrectOption = (qIndex, oIndex) => {
    const newQ = [...questions];
    newQ[qIndex].options.forEach((opt, idx) => opt.isCorrect = (idx === oIndex));
    setQuestions(newQ);
  };

  const addQuestion = () => setQuestions([...questions, {
    text: '', options: [{ text: '', isCorrect: true }, { text: '', isCorrect: false }, { text: '', isCorrect: false }, { text: '', isCorrect: false }]
  }]);

  const removeQuestion = (index) => {
    if (questions.length > 1) setQuestions(questions.filter((_, i) => i !== index));
  };

  const submitQuiz = async () => {
    // Validáció
    if (!quizData.title.trim()) return { success: false, msg: "Adj címet a kvíznek!" };
    if (questions.some(q => !q.text.trim())) return { success: false, msg: "Hiányzó kérdés szöveg!" };
    if (questions.some(q => q.options.some(opt => !opt.text.trim()))) return { success: false, msg: "Minden választ tölts ki!" };

    setLoading(true);
    setError(null);

    const userString = localStorage.getItem('user');
    const token = userString ? JSON.parse(userString).token : null;

    if (!token) { setLoading(false); return { success: false, msg: "Nem vagy bejelentkezve!" }; }

    try {
      const response = await fetch('http://localhost:8000/api/create', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json', 'Authorization': `Bearer ${token}` },
        body: JSON.stringify({ ...quizData, questions })
      });

      const text = await response.text();
      let data;
      try { data = JSON.parse(text); } catch { throw new Error("Szerver hiba (HTML válasz)"); }

      if (response.ok) {
        navigate('/profile');
        return { success: true };
      } else {
        setError(data.error || "Mentési hiba");
        return { success: false };
      }
    } catch (err) {
      setError("Hálózati hiba");
      return { success: false };
    } finally {
      setLoading(false);
    }
  };

  return {
    quizData, questions, loading, error,
    handleQuizChange, handleQuestionChange, handleOptionChange,
    setCorrectOption, addQuestion, removeQuestion, submitQuiz
  };
};