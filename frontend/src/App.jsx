import './index.css';
import { BrowserRouter, Routes, Route } from "react-router-dom";
import Navbar from "./components/layout/Navbar";
import Home from "./pages/Home";
import QuizList from "./components/quiz/QuizList";
import QuizGame from "./components/quiz/QuizGame";
import Leaderboard from "./pages//Leaderboard/Leaderboard";
// import QuizList from "./pages/QuizList";

import Login from "./pages/Login";
import Register from "./pages/Register";
import Profile from "./pages/Profile";
import CreateQuiz from "./pages/Admin/CreateQuiz";
import AdminRoute from './pages/Admin/AdminRoute';

function App() {
  return (
    <BrowserRouter>
      <Navbar />
      <div className="pt-20">
        <Routes>
          <Route path="/" element={<Home />} />
          <Route path="/quiz" element={<QuizList />} /> 
          <Route path="/login" element={<Login />} />
          <Route path="/register" element={<Register />} />
          <Route path="/profile" element={<Profile />} />
          <Route path="/leaderboard" element={<Leaderboard />} />
          <Route element={<AdminRoute />}>
        <Route path="/create" element={<CreateQuiz />} />
      </Route>
          <Route path="/quiz/:id" element={<QuizGame />} />
        </Routes>
      </div>
    </BrowserRouter>
  );
}

export default App;