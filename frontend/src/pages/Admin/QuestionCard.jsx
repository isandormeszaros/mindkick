import React from 'react';

const QuestionCard = ({ q, qIndex, onQChange, onOptChange, onCorrect, onRemove, canRemove }) => (
  <div className="bg-white p-6 rounded-xl shadow-sm border border-gray-100 relative">
    {canRemove && (
      <button onClick={() => onRemove(qIndex)} className="absolute top-4 right-4 text-red-500 font-bold bg-red-50 px-2 py-1 rounded hover:bg-red-100 transition-colors">Törlés</button>
    )}
    <h3 className="font-bold text-gray-800 mb-3 flex items-center">
      <span className="bg-purple-100 text-purple-700 w-8 h-8 flex items-center justify-center rounded-full mr-3 text-sm font-bold">{qIndex + 1}</span>
      Kérdés
    </h3>
    <input 
      value={q.text} 
      onChange={(e) => onQChange(qIndex, e.target.value)} 
      placeholder="Kérdés szövege..." 
      className="w-full p-3 border border-gray-200 rounded-lg mb-6 outline-none focus:ring-2 focus:ring-purple-500 focus:border-transparent transition-colors" 
    />
    
    <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
      {q.options.map((opt, oIndex) => (
        <div key={oIndex} className={`flex items-center p-3 rounded-lg border-2 transition-colors ${opt.isCorrect ? 'border-green-500 bg-green-50' : 'border-gray-200 hover:border-gray-300'}`}>
          <input 
            type="radio" 
            name={`correct-${qIndex}`} 
            checked={opt.isCorrect} 
            onChange={() => onCorrect(qIndex, oIndex)} 
            className="mr-3 w-5 h-5 accent-green-600 cursor-pointer" 
          />
          <input 
            value={opt.text} 
            onChange={(e) => onOptChange(qIndex, oIndex, e.target.value)} 
            placeholder={`${oIndex + 1}. Válasz`} 
            className="w-full bg-transparent outline-none text-gray-700 placeholder-gray-400" 
          />
        </div>
      ))}
    </div>
  </div>
);
export default QuestionCard;