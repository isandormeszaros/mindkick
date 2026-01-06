import { Link } from "react-router-dom";
import { HiArrowRight, HiSparkles } from "react-icons/hi";
import HeroImage from "../../assets/images/hero.webp"
import Button from "../../components/ui/Button"; 

function Hero() {
  return (
    <section className="relative pt-32 pb-20 lg:pt-20 lg:pb-20 overflow-hidden bg-white">
      <div className="absolute top-0 left-0 w-full h-full bg-[radial-gradient(circle_at_top_left,_var(--tw-gradient-stops))] from-purple-100/60 via-white to-white -z-10" />

      <div className="max-w-7xl mx-auto px-6">
        <div className="grid grid-cols-1 lg:grid-cols-2 gap-12 lg:gap-20 items-center">
          
          <div className="text-center lg:text-left animate-fade-in-up">
            <div className="inline-flex items-center gap-2 px-4 py-2 rounded-full bg-purple-100 text-purple-800 text-sm font-semibold mb-6 shadow-sm">
              <HiSparkles className="text-purple-600" />
              <span>Az #1 Kvíz Platform</span>
            </div>

            <h1 className="text-5xl lg:text-7xl font-extrabold text-gray-900 tracking-tight mb-6 leading-tight">
              Teszteld a tudásod.<br />
              <span className="text-transparent bg-clip-text bg-gradient-to-r from-purple-700 to-indigo-900 leading-[1.15]">
                Urald a ranglistát.
              </span>
            </h1>

            <p className="text-xl text-gray-600 max-w-xl mx-auto lg:mx-0 mb-10 leading-relaxed font-light">
              Vegyél részt izgalmas kihívásokban, gyűjts pontokat és versenyezz a barátaiddal. 
              A tanulás még sosem volt ennyire stílusos és szórakoztató.
            </p>

            <div className="flex flex-wrap items-center justify-center lg:justify-start gap-4">
              
              <Button 
                to="/quiz" 
                className="px-8 py-4 text-base w-full sm:w-auto flex items-center gap-2"
              >
                Játék Indítása <HiArrowRight />
              </Button>
              
              <Link
                to="/leaderboard"
                className="px-8 py-4 bg-gray-100 hover:bg-gray-200 text-gray-800 font-medium rounded-full transition w-full sm:w-auto text-center text-base"
              >
                Ranglista Megtekintése
              </Link>
            </div>
          </div>

          <div className="relative lg:order-last animate-fade-in flex justify-center lg:justify-end">
              <div className="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-[120%] h-[120%] bg-[radial-gradient(circle_at_center,_var(--tw-gradient-stops))] from-purple-200/40 via-transparent to-transparent blur-3xl -z-10"></div>
              
              <img 
                src={HeroImage} 
                alt="MindKick Kvíz Illusztráció" 
                className="relative z-10 w-full max-w-lg lg:max-w-none h-auto object-contain drop-shadow-2xl rounded-2xl transform hover:scale-[1.02] transition duration-500"
              />
          </div>

        </div>
      </div>
    </section>
  );
}

export default Hero;