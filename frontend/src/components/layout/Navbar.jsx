import { useState } from "react";
import { Link, NavLink } from "react-router-dom";
import { HiMenu, HiX } from "react-icons/hi";
import Logo from '../../../public/brain.svg';
import Button from "../ui/Button";

function Navbar() {
    const [open, setOpen] = useState(false);

    const navLinkStyle =
        "text-sm font-medium text-gray-600 hover:text-purple-600 transition duration-300";

    const mobileNavLinkStyle =
        "text-xl font-medium text-gray-900 hover:text-purple-600 transition py-2 block text-center";

    const closeMenu = () => setOpen(false);

    return (
        <nav className="fixed top-0 left-0 w-full bg-white/95 backdrop-blur-md border-b border-gray-100/50 z-50 shadow-sm">
            <div className="max-w-7xl mx-auto px-6 py-4 flex items-center justify-between">

                <Link to="/" className="flex items-center gap-2 group" onClick={closeMenu}>
                    <img src={Logo} alt="MindKick logo" className="w-10 h-10" />
                    <span className="text-transparent bg-clip-text bg-gradient-to-r from-pink-500 via-purple-500 to-blue-500 font-extrabold text-xl tracking-wide group-hover:brightness-110 transition-all">
                        MindKick
                    </span>
                </Link>

                <div className="hidden lg:flex items-center gap-8 flex-1 justify-center">
                    <NavLink to="/" className={navLinkStyle}>Játék</NavLink>
                    <NavLink to="/quiz" className={navLinkStyle}>Quizek</NavLink>
                    <NavLink to="/leaderboard" className={navLinkStyle}>Ranglista</NavLink>
                    <NavLink to="/gamesession" className={navLinkStyle}>Játékmenet</NavLink>
                    <NavLink to="/playwithfriends" className={navLinkStyle}>Játék barátok ellen</NavLink>
                </div>

                <div className="flex items-center gap-4">
                    <Button
                        to="/profile"
                        variant="primary"
                        className="hidden md:inline-flex !hidden md:!inline-flex"
                    >

                        Profilom
                    </Button>

                    <button
                        className="lg:hidden text-gray-600 text-3xl focus:outline-none hover:text-purple-600 transition"
                        onClick={() => setOpen(!open)}
                        aria-label="Toggle Menu"
                    >
                        {open ? <HiX /> : <HiMenu />}
                    </button>
                </div>
            </div>

            <div className={`lg:hidden absolute top-full left-0 w-full bg-white border-b border-gray-100 shadow-xl overflow-hidden transition-all duration-500 ease-in-out ${open ? "max-h-[80vh] opacity-100" : "max-h-0 opacity-0"}`}>
                <div className="px-6 py-8 flex flex-col gap-4 items-center">
                    <NavLink to="/" className={mobileNavLinkStyle} onClick={closeMenu}>Játék</NavLink>
                    <NavLink to="/quiz" className={mobileNavLinkStyle}>Quizek</NavLink>
                    <NavLink to="/leaderboard" className={mobileNavLinkStyle} onClick={closeMenu}>Ranglista</NavLink>
                    <NavLink to="/gamesession" className={mobileNavLinkStyle} onClick={closeMenu}>Játékmenet</NavLink>
                    <NavLink to="/playwithfriends" className={mobileNavLinkStyle} onClick={closeMenu}>Játék barátok ellen</NavLink>

                    <div className="w-full mt-6">
                        <Button to="/profile" variant="primary" className="w-full py-4 text-lg" onClick={closeMenu}>
                            Profilom
                        </Button>
                    </div>
                </div>
            </div>
        </nav>
    );
}

export default Navbar;