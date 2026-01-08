import { useEffect, useState } from 'react';
import { Link } from 'react-router-dom';
import QuizService from "../../services/QuizService";
import Button from "../ui/Button";

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
            <div key={q.id} className="bg-white p-6 rounded-2xl shadow-sm hover:shadow-md transition duration-300 border border-gray-100">
              <div className="flex justify-between items-start mb-4">
                <span className="text-xs font-bold text-gray-400 uppercase tracking-wider">
                  {q.category_name}
                </span>
                <span className={`px-3 py-1 rounded-full text-xs font-bold uppercase ${getDifficultyColor(q.difficulty)}`}>
                  {q.difficulty}
                </span>
              </div>

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
          /* Ez jelenik meg, ha nincs találat */
          <div className="col-span-full text-center py-12 text-gray-500">
            Nincs ilyen nehézségű kvíz. 😕
          </div>
        )}
      </div>
    </div>
  );
};

export default QuizList;