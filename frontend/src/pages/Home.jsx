import Hero from "./Home/Hero";
import Features from "./Home/Features";
import HowItWorks from "./Home/HowItWorks";
import Footer from "../components/layout/Footer";

function Home() {
  return (
    <div className="bg-[#0a0a14] min-h-screen text-white font-sans selection:bg-purple-500 selection:text-white">
      <main>
        <Hero />
        <Features />
        <HowItWorks />
      </main>
      <Footer />
    </div>
  );
}

export default Home;