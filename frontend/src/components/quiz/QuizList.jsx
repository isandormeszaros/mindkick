import { useEffect, useState } from 'react';
import { Link } from 'react-router-dom';
import QuizService from "../../services/QuizService";
import Button from "../ui/Button";
import axios from 'axios';
import { useNavigate } from 'react-router-dom';

const QuizList = () => {
  const [quizzes, setQuizzes] = useState([]);
  const [filter, setFilter] = useState('all');

  useEffect(() => {
    retrieveQuizzes();
  }, []);

  const retrieveQuizzes = () => {
    QuizService.getAll()
      .then(response => {
        setQuizzes(response.data);
      })
      .catch(e => {
        console.log(e);
      });
  };

  const getDifficultyColor = (diff) => {
    if (diff === 'easy') return 'bg-green-100 text-green-800';
    if (diff === 'medium') return 'bg-yellow-100 text-yellow-800';
    return 'bg-red-100 text-red-800';
  };

  const filteredQuizzes = quizzes.filter((q) => {
    if (filter === 'all') return true;
    return q.difficulty === filter;
  });

  const getFilterButtonStyle = (type) => {
    const baseStyle = "px-4 py-2 rounded-full text-sm font-bold transition-all duration-200 border ";
    if (filter === type) {
      return baseStyle + "bg-gray-800 text-white border-gray-800 shadow-md transform scale-105";
    }
    return baseStyle + "bg-white text-gray-600 border-gray-200 hover:bg-gray-50 hover:border-gray-300";
  };

  console.log(quizzes)

  const navigate = useNavigate();
  const userString = localStorage.getItem('user');
  const user = userString ? JSON.parse(userString) : null;

  const handleDelete = async (e, id) => {
    e.stopPropagation();
    if (!window.confirm("Tuti törlöd?")) return;

    try {
      await axios.delete(`http://localhost:8000/quiz/delete/${id}`, {
        headers: { Authorization: `Bearer ${user?.token}` }
      });
      window.location.reload();
    } catch (err) {
      alert("Hiba a törlésnél!");
    }
  };

  console.log("QuizList User:", user);

  console.log(user.role == "admin")

  return (
    <div className="md:container md:mx-auto mt-6">
      <div className="flex flex-wrap justify-center gap-3 mb-8">
        <button onClick={() => setFilter('all')} className={getFilterButtonStyle('all')}>
          Összes
        </button>
        <button onClick={() => setFilter('easy')} className={getFilterButtonStyle('easy')}>
          Könnyű
        </button>
        <button onClick={() => setFilter('medium')} className={getFilterButtonStyle('medium')}>
          Közepes
        </button>
        <button onClick={() => setFilter('hard')} className={getFilterButtonStyle('hard')}>
          Nehéz
        </button>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6 m-6">
        {filteredQuizzes.length > 0 ? (
          filteredQuizzes.map((q) => (
            <div key={q.id} className="bg-white p-6 rounded-2xl shadow-sm hover:shadow-md transition duration-300 border border-gray-100 relative">
              <div className="flex justify-between items-start mb-4">
                <span className="text-xs font-bold text-gray-400 uppercase tracking-wider">
                  {q.category_name}
                </span>
                <span className={`px-3 py-1 rounded-full text-xs font-bold uppercase ${getDifficultyColor(q.difficulty)}`}>
                  {q.difficulty}
                </span>
              </div>

              {user?.role === 'admin' && (
                <button
                  onClick={(e) => handleDelete(e, q.id)}
                  className="absolute top-4 right-24 text-gray-400 hover:text-red-600 bg-red-200 p-2 rounded-full transition z-20"
                  title="Törlés"
                >
                  <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" strokeWidth={1.5} stroke="currentColor" className="w-5 h-5">
                    <path strokeLinecap="round" strokeLinejoin="round" d="m14.74 9-.346 9m-4.788 0L9.26 9m9.968-3.21c.342.052.682.107 1.022.166m-1.022-.165L18.16 19.673a2.25 2.25 0 0 1-2.244 2.077H8.084a2.25 2.25 0 0 1-2.244-2.077L4.772 5.79m14.456 0a48.108 48.108 0 0 0-3.478-.397m-12 .562c.34-.059.68-.114 1.022-.165m0 0a48.11 48.11 0 0 1 3.478-.397m7.5 0v-.916c0-1.18-.91-2.164-2.09-2.201a51.964 51.964 0 0 0-3.32 0c-1.18.037-2.09 1.022-2.09 2.201v.916m7.5 0a48.667 48.667 0 0 0-7.5 0" />
                  </svg>
                </button>
              )}

              <h2 className="text-2xl font-bold mb-3 text-gray-800">{q.title}</h2>
              <p className="text-gray-600 mb-6 text-sm line-clamp-2">{q.description}</p>

              <div className="mt-auto pt-6 border-t border-gray-100">
                <Button
                  to={`/quiz/${q.id}`}
                  className="w-full shadow-md hover:shadow-lg"
                >
                  Indítás
                </Button>
              </div>
            </div>
          ))
        ) : (
          <div className="col-span-full text-center py-12 text-gray-500">
            Nincs ilyen nehézségű kvíz.
          </div>
        )}
      </div>
    </div>
  );
};

export default QuizList;