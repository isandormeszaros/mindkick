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
        setError("Lejárt a munkamenet. Jelentkezz be újra.");
        setLoading(false);
      }
    };

    fetchData();
  }, [navigate]);

  const handleLogout = () => {
    localStorage.removeItem('user');
    navigate('/login');
  };

  if (loading) return <div className="min-h-screen bg-slate-50 flex items-center justify-center text-slate-500 font-medium">Profil betöltése...</div>;
  if (error) return <div className="min-h-screen bg-slate-50 flex items-center justify-center text-red-500">{error}</div>;

  const { stats, badges } = data;

  return (
    <div className="min-h-screen bg-slate-50 text-slate-800 p-4 md:p-10 font-sans">
      <div className="max-w-5xl mx-auto space-y-8">
        
        <div className="bg-white border border-slate-200 p-8 rounded-3xl flex flex-col items-center md:flex-row md:justify-between shadow-sm">
          <div className="flex flex-col items-center md:flex-row gap-6">
            <div className="relative">
              <img 
                src={data.avatar || `https://api.dicebear.com/7.x/avataaars/svg?seed=${data.username}`} 
                alt="avatar" 
                className="w-24 h-24 rounded-full border-4 border-white shadow-md bg-slate-100"
              />
              <div className="absolute bottom-1 right-1 bg-green-500 w-5 h-5 rounded-full border-4 border-white"></div>
            </div>
            <div className="text-center md:text-left">
              <h1 className="text-3xl font-bold text-slate-900">{data.username}</h1>
              <p className="text-slate-500 font-medium italic">Mindkick Kalandor</p>
            </div>
          </div>
          <button 
            onClick={handleLogout}
            className="mt-6 md:mt-0 bg-slate-100 hover:bg-red-50 hover:text-red-600 text-slate-600 py-2 px-6 rounded-xl border border-slate-200 transition-all font-semibold"
          >
            Kijelentkezés
          </button>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
          <StatCard title="Összpontszám" value={stats.totalScore} icon="⭐" bgColor="bg-yellow-50" textColor="text-yellow-700" />
          <StatCard title="Kvíz Széria" value={`${stats.streak} nap`} icon="🔥" bgColor="bg-orange-50" textColor="text-orange-700" />
          <StatCard title="Kitöltött kvízek" value={stats.quizzesCompleted} icon="📊" bgColor="bg-blue-50" textColor="text-blue-700" />
        </div>

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
  <div className="bg-white border border-slate-200 p-6 rounded-2xl shadow-sm flex items-center gap-5">
    <div className={`text-3xl p-4 ${bgColor} rounded-2xl`}>{icon}</div>
    <div>
      <div className={`text-2xl font-bold ${textColor}`}>{value}</div>
      <div className="text-slate-400 text-xs font-bold uppercase tracking-widest">{title}</div>
    </div>
  </div>
);

const BadgeItem = ({ active, icon, name, desc }) => (
  <div className={`flex flex-col items-center p-5 rounded-2xl transition-all ${active ? 'bg-white border-2 border-blue-100 shadow-md scale-105' : 'bg-slate-50 border border-slate-100 opacity-40 grayscale'}`}>
    <div className="text-4xl mb-3">{active ? icon : '🔒'}</div>
    <div className="font-bold text-sm text-slate-800 text-center mb-1">{name}</div>
    <div className="text-[10px] text-slate-400 text-center font-medium">{desc}</div>
  </div>
);

export default Profile;