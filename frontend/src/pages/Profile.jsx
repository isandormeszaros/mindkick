import React, { useEffect, useState } from 'react';
import axios from 'axios';
import { useNavigate } from 'react-router-dom';

const Profile = () => {
  const [data, setData] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");
  const navigate = useNavigate();

  useEffect(() => {
    const fetchData = async () => {
      const userString = localStorage.getItem('user');
      if (!userString) {
        navigate('/login');
        return;
      }

      const userObj = JSON.parse(userString);
      const token = userObj.token;

      try {
        const res = await axios.get('http://localhost:8000/api/users/profile', {
          headers: { Authorization: `Bearer ${token}` }
        });
        
        setData(res.data);
        setLoading(false);
      } catch (err) {
  console.error("Hiba:", err);
  localStorage.removeItem('user');
  setLoading(false);
  navigate('/login');
}

    fetchData();
  }, [navigate]);

  const handleLogout = () => {
    localStorage.removeItem('user');
    navigate('/login');
  };

  if (loading) return <div className="min-h-screen bg-slate-50 flex items-center justify-center text-slate-500 font-medium animate-pulse">Profil betöltése...</div>;
  if (error) return <div className="min-h-screen bg-slate-50 flex items-center justify-center text-red-500">{error}</div>;

  const { stats, badges, categoryStats } = data;

  return (
    <div className="min-h-screen bg-slate-50 text-slate-800 p-4 md:p-10 font-sans">
      <div className="max-w-5xl mx-auto space-y-8">
        
        {/* 3. LAYOUT*/}
        <div className="bg-white border border-slate-200 p-8 rounded-3xl flex flex-col items-center md:flex-row md:justify-between shadow-sm">
          <div className="flex flex-col items-center md:flex-row gap-6 w-full md:w-auto">
            <div className="relative">
              <img 
                src={data.avatar || `https://api.dicebear.com/7.x/avataaars/svg?seed=${data.username}`} 
                alt="avatar" 
                className="w-24 h-24 rounded-full border-4 border-white shadow-md bg-slate-100"
              />
              <div className="absolute bottom-1 right-1 bg-green-500 w-5 h-5 rounded-full border-4 border-white"></div>
            </div>
            <div className="text-center md:text-left w-full">
              <h1 className="text-3xl font-bold text-slate-900">{data.username}</h1>
              <p className="text-slate-500 font-medium italic mb-3">Mindkick Kalandor</p>
              
              {/* XP Folyamatjelző */}
              <div className="w-full max-w-xs mx-auto md:mx-0">
                <div className="flex justify-between mb-1 text-[10px] font-bold text-slate-400 uppercase tracking-widest">
                  <span>{stats.xp} Össz XP</span>
                  <span>Szint {Math.floor(stats.xp / 100) + 1}</span>
                </div>
                <div className="w-full bg-slate-100 rounded-full h-1.5">
                  <div 
                    className="bg-blue-500 h-1.5 rounded-full transition-all duration-700 shadow-[0_0_8px_rgba(59,130,246,0.5)]" 
                    style={{ width: `${stats.xp % 100}%` }}
                  ></div>
                </div>
              </div>
            </div>
          </div>
          <button 
            onClick={handleLogout}
            className="mt-6 md:mt-0 bg-slate-100 hover:bg-red-50 hover:text-red-600 text-slate-600 py-2 px-6 rounded-xl border border-slate-200 transition-all font-semibold whitespace-nowrap"
          >
            Kijelentkezés
          </button>
        </div>

        {/* 2. STATISZTIKA: Alapok*/}
        <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
          <StatCard title="Összpontszám" value={stats.totalScore} icon="⭐" bgColor="bg-yellow-50" textColor="text-yellow-700" />
          <StatCard title="Kvíz Széria" value={`${stats.streak} nap`} icon="🔥" bgColor="bg-orange-50" textColor="text-orange-700" />
          <StatCard title="Kitöltött kvízek" value={stats.quizzesCompleted} icon="📊" bgColor="bg-blue-50" textColor="text-blue-700" />
        </div>

        {/* 2. STATISZTIKA: Részletes kimutatás */}
        <div className="bg-white border border-slate-200 p-8 rounded-3xl shadow-sm">
          <h2 className="text-xl font-bold mb-8 text-slate-900 flex items-center gap-2">
            <span className="p-2 bg-slate-100 rounded-lg">📈</span> Erősségek kategóriánként
          </h2>
          <div className="grid grid-cols-1 md:grid-cols-2 gap-x-12 gap-y-6">
            {categoryStats && categoryStats.length > 0 ? (
              categoryStats.map((stat, index) => (
                <div key={index} className="space-y-2">
                  <div className="flex justify-between text-xs font-bold uppercase tracking-wide">
                    <span className="text-slate-600">{stat.category_name}</span>
                    <span className="text-slate-400">{stat.average_score}%</span>
                  </div>
                  <div className="w-full bg-slate-100 rounded-full h-2">
                    <div 
                      className={`h-2 rounded-full transition-all duration-1000 ${
                        stat.average_score > 80 ? 'bg-green-400' : 
                        stat.average_score > 50 ? 'bg-blue-400' : 'bg-orange-400'
                      }`}
                      style={{ width: `${stat.average_score}%` }}
                    ></div>
                  </div>
                </div>
              ))
            ) : (
              <p className="col-span-2 text-slate-400 italic text-center py-4 text-sm">Még nincsenek kategória alapú statisztikáid.</p>
            )}
          </div>
        </div>

        {/* 1. BADGES*/}
        <div className="bg-white border border-slate-200 p-8 rounded-3xl shadow-sm">
          <h2 className="text-xl font-bold mb-8 text-slate-900 flex items-center gap-2">
            <span className="p-2 bg-slate-100 rounded-lg">🏅</span> Megszerzett Eredmények
          </h2>
          
          <div className="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 lg:grid-cols-5 gap-6">
            <BadgeItem 
              active={badges.hasFirstQuiz} 
              icon="🚀" 
              name="Újonc" 
              desc="Az első lépés" 
            />
            <BadgeItem 
              active={stats.perfectCount > 0} 
              icon="💎" 
              name="Maximalista" 
              desc={`${stats.perfectCount} db 100%`} 
            />
            <BadgeItem 
              active={stats.streak >= 3} 
              icon="⚡" 
              name="Lendületben" 
              desc="3 napos széria" 
            />
           
              {badges.earned && badges.earned.map((b, i) => (
                <BadgeItem key={i} active={true} icon="🏆" name={b.name} desc={b.description} />
              ))}
          </div>
        </div>

      </div>
    </div>
  );
};

const StatCard = ({ title, value, icon, bgColor, textColor }) => (
  <div className="bg-white border border-slate-200 p-6 rounded-2xl shadow-sm flex items-center gap-5 hover:border-slate-300 transition-colors">
    <div className={`text-3xl p-4 ${bgColor} rounded-2xl`}>{icon}</div>
    <div>
      <div className={`text-2xl font-black ${textColor}`}>{value}</div>
      <div className="text-slate-400 text-[10px] font-bold uppercase tracking-widest">{title}</div>
    </div>
  </div>
);

const BadgeItem = ({ active, icon, name, desc }) => (
  <div className={`flex flex-col items-center p-5 rounded-2xl transition-all duration-300 ${active ? 'bg-white border-2 border-blue-50 shadow-md scale-105' : 'bg-slate-50 border border-slate-100 opacity-30 grayscale hover:opacity-50'}`}>
    <div className="text-4xl mb-3">{active ? icon : '🔒'}</div>
    <div className="font-bold text-[13px] text-slate-800 text-center mb-1 leading-tight">{name}</div>
    <div className="text-[9px] text-slate-400 text-center font-bold uppercase tracking-tighter">{desc}</div>
  </div>
);

export default Profile;