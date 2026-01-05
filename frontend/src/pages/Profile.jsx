import React, { useEffect, useState } from 'react';
import axios from 'axios';
import { useNavigate } from 'react-router-dom';

const Profile = () => {
  const [user, setUser] = useState(null);       
  const [loading, setLoading] = useState(true); 
  const [error, setError] = useState("");       
  const navigate = useNavigate();

  useEffect(() => {
    const fetchData = async () => {
     
      const token = localStorage.getItem('token');
      
      if (!token) {
        navigate('/login'); 
      }

      try {

        const res = await axios.get('http://localhost:8000/api/users/profile', {
          headers: {
            Authorization: `Bearer ${token}` 
          }
        });
        
        setUser(res.data);
        setLoading(false);
      } catch (err) {
        console.error("Hiba:", err);
        setError("Nem sikerült betölteni az adatokat. Lehet, hogy lejárt a bejelentkezésed.");
        setLoading(false);
      }
    };

    fetchData();
  }, [navigate]);

  
  if (loading) return <div className="p-10 text-white text-center">Betöltés...</div>;
  
  
  if (error) return <div className="p-10 text-red-500 text-center">{error}</div>;

 
  return (
    <div className="min-h-screen bg-gray-900 text-white p-10 flex flex-col items-center">
      <div className="bg-gray-800 p-8 rounded-lg shadow-lg w-full max-w-md text-center">
        <h1 className="text-4xl font-bold mb-4 text-blue-400">{user.username}</h1>
        <p className="text-gray-400 mb-6">{user.email}</p>
        
        <div className="grid grid-cols-2 gap-4 w-full">
          <div className="bg-gray-700 p-4 rounded-lg">
            <h2 className="text-xl font-bold text-yellow-400">Szint</h2>
            <p className="text-2xl">{user.level || 1}</p>
          </div>
          <div className="bg-gray-700 p-4 rounded-lg">
            <h2 className="text-xl font-bold text-green-400">XP</h2>
            <p className="text-2xl">{user.xp || 0}</p>
          </div>
        </div>

        <button 
          onClick={() => {
            localStorage.removeItem('token'); 
          }}
          className="mt-8 bg-red-600 hover:bg-red-700 text-white py-2 px-6 rounded transition"
        >
          Kijelentkezés
        </button>
      </div>
    </div>
  );
};

export default Profile;