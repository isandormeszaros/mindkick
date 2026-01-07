import React, { useState } from 'react';
import { useNavigate, Link } from 'react-router-dom';
import { toast } from 'react-toastify';
import Button from "../components/ui/Button";
import AuthService from "../services/authService"; // <--- Service importálása

const Register = () => {
  const [credentials, setCredentials] = useState({
    username: "",
    email: "",
    password: ""
  });
  const [error, setError] = useState("");
  const navigate = useNavigate();

  const { username, email, password } = credentials;

  const onChange = (e) =>
    setCredentials({ ...credentials, [e.target.name]: e.target.value });

  const onSubmit = async (e) => {
    e.preventDefault();
    try {
      // Regisztráció hívása
      await AuthService.register(username, email, password);
      
      // Sikerüzenet (most már működni fog a toast, mert telepítettük)
      toast.success("Sikeres regisztráció! Most jelentkezz be.");
      
      // Átirányítás a bejelentkezéshez
      navigate("/login"); 
    } catch (err) {
      const errorMessage = err.response?.data?.msg || "Hiba történt a regisztrációkor.";
      setError(errorMessage);
      toast.error(errorMessage);
    }
  };

  return (
    <div className="min-h-screen bg-white flex items-center justify-center pt-20">
      <div className="bg-white p-10 rounded-2xl shadow-2xl w-full max-w-md border border-purple-100 relative overflow-hidden">
        <div className="absolute top-0 left-1/2 -translate-x-1/2 w-full h-24 bg-purple-50 blur-3xl rounded-full -z-10"></div>

        <h1 className="text-4xl font-extrabold mb-8 text-center text-purple-900">
          Regisztráció
        </h1>
        
        {error && <p className="bg-red-50 border border-red-200 text-red-600 p-3 rounded-lg mb-6 text-center text-sm">{error}</p>}

        <form onSubmit={onSubmit} className="flex flex-col gap-5">
          <div>
            <label className="block text-purple-900 text-sm mb-2 font-bold">Felhasználónév</label>
            <input
              type="text"
              name="username"
              value={username}
              onChange={onChange}
              placeholder="Pl. Jatekos123"
              className="w-full p-4 rounded-xl bg-purple-50 border border-purple-200 text-gray-900 placeholder-purple-300 focus:outline-none focus:border-purple-500 focus:ring-2 focus:ring-purple-200 transition"
              required
            />
          </div>
          
          <div>
            <label className="block text-purple-900 text-sm mb-2 font-bold">Email cím</label>
            <input
              type="email"
              name="email"
              value={email}
              onChange={onChange}
              placeholder="pelda@email.com"
              className="w-full p-4 rounded-xl bg-purple-50 border border-purple-200 text-gray-900 placeholder-purple-300 focus:outline-none focus:border-purple-500 focus:ring-2 focus:ring-purple-200 transition"
              required
            />
          </div>

          <div>
             <label className="block text-purple-900 text-sm mb-2 font-bold">Jelszó</label>
             <input
              type="password"
              name="password"
              value={password}
              onChange={onChange}
              placeholder="Minimum 6 karakter"
              className="w-full p-4 rounded-xl bg-purple-50 border border-purple-200 text-gray-900 placeholder-purple-300 focus:outline-none focus:border-purple-500 focus:ring-2 focus:ring-purple-200 transition"
              required
              minLength="6"
            />
          </div>

          <Button
            type="submit"
            className="w-full py-4 text-base font-bold shadow-lg shadow-purple-200 mt-2 bg-gradient-to-r from-purple-600 to-indigo-600 hover:from-purple-700 hover:to-indigo-700 border-none text-white"
          >
            Fiók Létrehozása
          </Button>
        </form>

        <p className="text-gray-500 text-center mt-8 text-sm">
          Már van fiókod?{' '}
          <Link to="/login" className="text-purple-600 hover:text-purple-800 font-bold hover:underline">
            Jelentkezz be itt!
          </Link>
        </p>
      </div>
    </div>
  );
};

export default Register;