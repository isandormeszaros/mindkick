import { Link } from "react-router-dom";
import Logo from '../../../src/img/brain.svg';

function Footer() {
  const linkStyle = "text-purple-200/80 hover:text-white transition-colors duration-300";

  return (
    <footer className="bg-linear-to-br from-[#3b0764] via-[#831843] to-[#1e3a8a] text-white pt-20 pb-10 relative overflow-hidden">
      <div className="absolute inset-0 opacity-10 bg-[radial-gradient(circle_at_center,var(--tw-gradient-stops))] from-white via-transparent to-transparent pointer-events-none"></div>
      <div className="max-w-7xl mx-auto px-6 relative z-10">
        <div className="grid grid-cols-1 md:grid-cols-4 gap-12 mb-16">
          <div className="col-span-1 md:col-span-2">
            <Link to="/" className="flex items-center gap-3 mb-6 group w-fit">
              <img src={Logo} alt="MindKick logo" className="w-8 h-8 brightness-0 invert group-hover:scale-110 transition-transform" />
              <span className="font-extrabold text-2xl tracking-tight text-white">MindKick</span>
            </Link>
            <p className="text-purple-200/90 max-w-sm text-lg leading-relaxed">
              Teszteld tudásod, versenyezz barátaiddal és lépj feljebb a ranglistán!
            </p>
          </div>
          <div>
            <h4 className="text-white font-bold mb-6 uppercase tracking-wider text-sm opacity-90">Navigáció</h4>
            <ul className="space-y-4 font-medium">
              <li><Link to="/" className={linkStyle}>Játék</Link></li>
              <li><Link to="/categories" className={linkStyle}>Kategóriák</Link></li>
              <li><Link to="/leaderboard" className={linkStyle}>Ranglista</Link></li>
              <li><Link to="/gamesession" className={linkStyle}>Játékmenet</Link></li>
              <li><Link to="/playwithfriends" className={linkStyle}>Játék barátok ellen</Link></li>
            </ul>
          </div>
          <div>
            <h4 className="text-white font-bold mb-6 uppercase tracking-wider text-sm opacity-90">Jogi információk</h4>
            <ul className="space-y-4 font-medium">
              <li><Link to="/about" className={linkStyle}>Rólunk</Link></li>
              <li><Link to="/privacy" className={linkStyle}>Adatvédelem</Link></li>
              <li><Link to="/terms" className={linkStyle}>Felhasználási feltételek</Link></li>
            </ul>
          </div>
        </div>
        <div className="border-t border-white/10 pt-8 flex flex-col md:flex-row items-center justify-center text-purple-200/70 text-sm">
          <p>© 2025 MindKick Inc. Minden jog fenntartva.</p>
        </div>
      </div>
    </footer>
  );
}

export default Footer;