import React from 'react';

const QuizBasicInfo = ({ quizData, onChange }) => (
  <div className="bg-white p-6 rounded-xl shadow-sm border border-gray-100 mb-8">

    <h2 className="text-lg font-bold text-gray-700 mb-4 border-b border-gray-100 pb-2">Alapadatok</h2>

    <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
      <div className="col-span-2">
        <label className="block text-sm font-medium text-gray-600 mb-1">Kvíz Címe</label>
        <input
          name="title"
          value={quizData.title}
          onChange={onChange}
          className="w-full p-3 border border-gray-200 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-transparent outline-none transition-colors"
          placeholder="Pl. Filmkvíz"
        />
      </div>
      <div>
        <label className="block text-sm font-medium text-gray-600 mb-1">Kategória</label>
        <select
          name="category_id"
          value={quizData.category_id}
          onChange={onChange}
          className="w-full p-3 border border-gray-200 rounded-lg bg-white focus:ring-2 focus:ring-purple-500 focus:border-transparent outline-none transition-colors"
        >
          <option value="1">Filmek</option>
          <option value="2">Matematika</option>
          <option value="3">Kaland & Utazás</option>
          <option value="4">Programozás</option>
          <option value="5">Autók</option>
          <option value="6">Gaming</option>
          <option value="7">Történelem</option>
          <option value="8">Logika</option>
          <option value="9">Zene</option>
          <option value="10">Tudomány</option>
          <option value="11">Sport</option>
          <option value="12">Gasztronómia</option>
        </select>
      </div>
      <div>
        <label className="block text-sm font-medium text-gray-600 mb-1">Nehézség</label>
        <select
          name="difficulty"
          value={quizData.difficulty}
          onChange={onChange}
          className="w-full p-3 border border-gray-200 rounded-lg bg-white focus:ring-2 focus:ring-purple-500 focus:border-transparent outline-none transition-colors"
        >
          <option value="easy">Könnyű</option>
          <option value="medium">Közepes</option>
          <option value="hard">Nehéz</option>
        </select>
      </div>
      <div className="col-span-2">
        <label className="block text-sm font-medium text-gray-600 mb-1">Leírás</label>
        <textarea
          name="description"
          value={quizData.description}
          onChange={onChange}
          
          className="w-full p-3 border border-gray-200 rounded-lg h-24 resize-none focus:ring-2 focus:ring-purple-500 focus:border-transparent outline-none transition-colors"
          placeholder="Leírás..."
        />
      </div>
    </div>
  </div>
);
export default QuizBasicInfo;