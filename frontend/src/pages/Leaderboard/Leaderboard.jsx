import React, { useEffect, useState } from 'react';
import QuizService from '../../services/QuizService';

const Leaderboard = () => {
  const [leaders, setLeaders] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchLeaderboard = async () => {
      try {
        const res = await QuizService.getLeaderboard();
        setLeaders(res.data);
      } catch (err) {
        console.error(err);
      } finally {
        setLoading(false);
      }
    };

    fetchLeaderboard();
  }, []);

  const getRankIcon = (index) => {
    return index + 1 + ".";
  };

  const getRowStyle = (index) => {
    if (index === 0) return "bg-yellow-50 border-yellow-200";
    if (index === 1) return "bg-gray-50 border-gray-200";
    if (index === 2) return "bg-orange-50 border-orange-200";
    return "bg-white border-gray-100 hover:bg-gray-50";
  };

  if (loading) return <div className="text-center p-10">Betöltés...</div>;

  return (
    <div className="max-w-4xl mx-auto p-6 min-h-screen">
      <div className="text-center mb-10">
        <h1 className="text-4xl font-extrabold text-gray-800 mb-2">Ranglista</h1>
        <p className="text-gray-500">A QuizPlatform legjobbjai</p>
      </div>

      <div className="bg-white rounded-2xl shadow-xl overflow-hidden border border-gray-100">
        <div className="grid grid-cols-12 gap-4 p-4 bg-gray-800 text-white font-bold text-sm uppercase tracking-wider">
          <div className="col-span-2 text-center">Helyezés</div>
          <div className="col-span-6">Játékos</div>
          <div className="col-span-2 text-center">Pontszám</div>
          <div className="col-span-2 text-center hidden sm:block">Kvízek</div>
        </div>

        <div className="divide-y divide-gray-100">
          {leaders.map((user, index) => (
            <div 
              key={index} 
              className={`grid grid-cols-12 gap-4 p-4 items-center transition duration-300 border-l-4 ${getRowStyle(index)} ${index === 0 ? 'border-l-yellow-400' : index === 1 ? 'border-l-gray-400' : index === 2 ? 'border-l-orange-400' : 'border-l-transparent'}`}
            >
              <div className="col-span-2 text-center font-bold text-xl text-gray-700">
                {getRankIcon(index)}
              </div>

              <div className="col-span-6 flex items-center gap-3">
                <img 
                  src={user.avatar_url || `https://ui-avatars.com/api/?name=${user.username}&background=random`} 
                  alt="avatar" 
                  className="w-10 h-10 rounded-full border-2 border-white shadow-sm"
                />
                <div>
                  <p className="font-bold text-gray-800">
                    {user.display_name || user.username}
                  </p>
                  {index === 0 && <span className="text-xs text-yellow-600 font-bold">👑 Bajnok</span>}
                </div>
              </div>

              <div className="col-span-2 text-center">
                <span className="font-mono font-bold text-purple-600 text-lg">
                  {user.total_score} XP
                </span>
              </div>

              <div className="col-span-2 text-center hidden sm:block text-gray-500 font-medium">
                {user.quizzes_completed} db
              </div>
            </div>
          ))}

          {leaders.length === 0 && (
            <div className="p-8 text-center text-gray-500">
              Még senki nem szerzett pontot. Légy te az első!
            </div>
          )}
        </div>
      </div>
    </div>
  );
};

export default Leaderboard;