import { useState, useEffect } from "react";
import Confetti from "react-confetti";

const QuizResult = ({ result, questions, userAnswers, onRetry, onNavigateNext }) => {
  const [showDetails, setShowDetails] = useState(false);
  const [windowSize, setWindowSize] = useState({ width: window.innerWidth, height: window.innerHeight });

  useEffect(() => {
    const handleResize = () => setWindowSize({ width: window.innerWidth, height: window.innerHeight });
    window.addEventListener('resize', handleResize);
    return () => window.removeEventListener('resize', handleResize);
  }, []);

  const isSuccess = result.percentage >= 50;

  return (
    <div className="max-w-2xl mx-auto bg-white p-8 rounded-3xl shadow-xl mt-10 border border-gray-100">
      
{isSuccess && (
        <Confetti 
          width={windowSize.width} 
          height={windowSize.height} 
          recycle={false}      
          numberOfPieces={500} 
          gravity={0.15}
          style={{ position: 'fixed', top: 0, left: 0, zIndex: 50 }} 
        />
      )}

      {/* Eredmény Kör */}
      <div className="text-center">
        <h2 className="text-3xl font-bold mb-6 text-gray-800">Eredmény</h2>
        <div className="relative w-40 h-40 mx-auto flex items-center justify-center rounded-full border-8 border-blue-50 mb-6 bg-blue-50/30">
          <span className="text-4xl font-black text-blue-600">{result.percentage}%</span>
        </div>
        <p className="text-lg text-gray-600 mb-8">
          <span className="font-bold text-gray-900">{result.score}</span> helyes válasz a <span className="font-bold text-gray-900">{result.total}</span> kérdésből.
        </p>
      </div>

      {/* Ajánló */}
      {result.recommendedQuiz && (
        <div 
          className="bg-gray-50 rounded-xl p-5 mb-8 text-left border border-gray-200 hover:shadow-md transition-shadow cursor-pointer"
          onClick={() => onNavigateNext(result.recommendedQuiz.id)}
        >
          <div className="text-xs font-bold text-gray-400 uppercase tracking-wide mb-1">Következő kihívás</div>
          <div className="flex justify-between items-center">
            <div>
              <h4 className="font-bold text-gray-800 text-lg">{result.recommendedQuiz.title}</h4>
              <span className={`text-xs font-bold px-2 py-0.5 rounded text-white ${
                result.recommendedQuiz.difficulty === 'hard' ? 'bg-red-500' : 
                result.recommendedQuiz.difficulty === 'medium' ? 'bg-yellow-500' : 'bg-green-500'
              }`}>
                {result.recommendedQuiz.difficulty.toUpperCase()}
              </span>
            </div>
            <div className="bg-white p-2 rounded-full shadow-sm text-blue-600">➡️</div>
          </div>
        </div>
      )}

      {/* Részletek */}
      <button 
        onClick={() => setShowDetails(!showDetails)}
        className="w-full mb-6 py-3 text-blue-600 font-bold border border-blue-100 rounded-xl hover:bg-blue-50 transition flex justify-center items-center gap-2"
      >
        {showDetails ? "Részletek elrejtése" : "Válaszaim ellenőrzése"} 
      </button>

      {showDetails && (
        <div className="space-y-6 mb-8 text-left animate-fade-in">
          {questions.map((q, index) => {
            const userAnswer = userAnswers.find(a => a.questionId === q.id);
            const userSelectedId = userAnswer ? userAnswer.selectedOptionId : null;
            const correctOptionId = result.evaluation ? result.evaluation[q.id] : null;
            const isCorrect = userSelectedId === correctOptionId;

            return (
              <div key={q.id} className={`p-4 rounded-xl border border-stone-200`}>
                <p className="font-bold text-gray-800 mb-3 text-sm">
                  {index + 1}. {q.text}
                </p>
                <div className="space-y-2">
                  {q.options.map(opt => {
                    let styleClass = "p-3 rounded-lg border text-sm flex justify-between items-center ";
                    if (opt.id === correctOptionId) {
                      styleClass += "bg-green-100 border-green-300 text-green-800 font-bold";
                    } else if (opt.id === userSelectedId && !isCorrect) {
                      styleClass += "bg-red-100 border-red-300 text-red-800 line-through opacity-80";
                    } else {
                      styleClass += "bg-white border-gray-100 text-gray-400";
                    }
                    return (
                      <div key={opt.id} className={styleClass}>
                            <span>{opt.text}</span>
                      </div>
                    );
                  })}
                </div>
              </div>
            );
          })}
        </div>
      )}

      <button
        onClick={onRetry}
        className="w-full bg-gray-900 text-white py-3.5 rounded-xl font-bold hover:bg-gray-800 transition active:scale-[0.98]"
      >
        Vissza a főoldalra
      </button>
    </div>
  );
};

export default QuizResult;