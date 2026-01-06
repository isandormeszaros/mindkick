const QuizPlayArea = ({ 
  quizTitle, 
  difficulty, 
  question, 
  currentIndex, 
  totalQuestions, 
  timeLeft, 
  onAnswer 
}) => {
  const formatTime = (seconds) => {
    const minutes = Math.floor(seconds / 60);
    const secs = seconds % 60;
    return `${minutes}:${secs < 10 ? '0' : ''}${secs}`;
  };

  const progress = ((currentIndex + 1) / totalQuestions) * 100;

  return (
    <div className="max-w-2xl mx-auto mt-8">
      <div className="mb-8">
        {/* Fejléc */}
        <div className="flex justify-between items-center mb-2">
          <h2 className="text-3xl font-bold text-gray-900">{quizTitle}</h2>
          <span className="px-3 py-1 bg-gray-200 rounded-full text-xs font-bold uppercase text-gray-600">
            {difficulty}
          </span>
        </div>

        {/* Progress Bar */}
        <div className="w-full bg-gray-200 rounded-full h-3 mt-4 overflow-hidden">
          <div
            className="bg-blue-600 h-3 rounded-full transition-all duration-500 ease-out"
            style={{ width: `${progress}%` }}
          ></div>
        </div>

        {/* Timer */}
        <div className="flex justify-between items-center mt-2">
          <span className="text-gray-500 font-medium">{currentIndex + 1} / {totalQuestions}</span>
          <div className={`text-xl font-bold ${timeLeft < 10 ? 'text-red-500 animate-pulse' : 'text-blue-600'}`}>
            {formatTime(timeLeft)}
          </div>
        </div>
      </div>

      {/* Kérdés Kártya */}
      <div className="bg-white p-8 rounded-2xl shadow-lg border border-gray-100">
        <h3 className="text-xl font-semibold mb-8 text-gray-800 leading-relaxed">
          {question?.text}
        </h3>

        <div className="space-y-4">
          {question?.options.map((opt) => (
            <button
              key={opt.id}
              onClick={() => onAnswer(opt.id)}
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

export default QuizPlayArea;