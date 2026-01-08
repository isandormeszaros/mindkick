import React from 'react';
import Button from '../../components/ui/Button';
import { useCreateQuiz } from '../../hooks/CreateQuiz'; 
import QuizBasicInfo from './QuizBasicInfo';
import QuestionCard from './QuestionCard';

const CreateQuiz = () => {
  const { 
    quizData, questions, loading, error, 
    handleQuizChange, handleQuestionChange, handleOptionChange, 
    setCorrectOption, addQuestion, removeQuestion, submitQuiz 
  } = useCreateQuiz();

  const handleSave = async () => {
    const res = await submitQuiz();
    if (res.success) alert("sikeres");
    else if (res.msg) alert(res.msg);
  };

  return (
    <div className="max-w-4xl mx-auto p-6 bg-gray-50 min-h-screen">
      <div className="flex justify-between items-center mb-8">
        <h1 className="text-3xl font-extrabold text-gray-900">Új Kvíz 🛠️</h1>
        <Button to="/" className="bg-gray-500 text-xs px-4 py-2">Mégse</Button>
      </div>

      {error && <div className="bg-red-100 text-red-700 p-4 rounded-lg mb-6">{error}</div>}

      <QuizBasicInfo quizData={quizData} onChange={handleQuizChange} />

      <div className="space-y-6">
        {questions.map((q, index) => (
          <QuestionCard 
            key={index} 
            q={q} qIndex={index} 
            onQChange={handleQuestionChange} 
            onOptChange={handleOptionChange} 
            onCorrect={setCorrectOption} 
            onRemove={removeQuestion} 
            canRemove={questions.length > 1}
          />
        ))}
      </div>

      <div className="mt-8 flex gap-4 border-t pt-6">
        <button onClick={addQuestion} className="bg-white border hover:bg-gray-50 text-gray-700 font-bold py-3 px-6 rounded-xl">
          + Új kérdés
        </button>
        <Button onClick={handleSave} disabled={loading} className="py-3 px-8">
          {loading ? "Mentés..." : "Kvíz Mentése"}
        </Button>
      </div>
    </div>
  );
};

export default CreateQuiz;