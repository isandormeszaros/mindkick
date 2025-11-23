import './index.css';
import { BrowserRouter, Routes, Route } from "react-router-dom";
import Navbar from "./components/layout/Navbar";
import Home from "./pages/Home";
// import QuizList from "./pages/QuizList";
// import Leaderboard from "./pages/Leaderboard";

function App() {
  return (
    <BrowserRouter>
      <Navbar />
      <div className="pt-20">
        <Routes>
          <Route path="/" element={<Home />} />
          {/* <Route path="/quiz" element={<QuizList />} /> */}
          {/* <Route path="/leaderboard" element={<Leaderboard />} /> */}
        </Routes>
      </div>
    </BrowserRouter>
  );
}

export default App;