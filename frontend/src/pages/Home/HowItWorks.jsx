const steps = [
  { id: "01", title: "Regisztrálj", desc: "Hozz létre egy fiókot pillanatok alatt." },
  { id: "02", title: "Válassz Témát", desc: "Böngéssz a kedvenc kategóriáid között." },
  { id: "03", title: "Játssz", desc: "Válaszolj helyesen és zsebeld be a pontokat!" },
];

function HowItWorks() {
  return (
    <section className="py-24 relative overflow-hidden bg-white">
      <div className="max-w-6xl mx-auto px-6">
        <div className="flex flex-col lg:flex-row items-center justify-between gap-16">
          
          <div className="lg:w-1/2">
            <h2 className="text-3xl md:text-5xl font-extrabold text-gray-900 mb-6 leading-tight">
              Hogyan működik?
            </h2>
            <p className="text-gray-600 text-xl mb-12 leading-relaxed">
              A MindKick használata egyszerű és intuitív. A letisztult felület segít a lényegre koncentrálni.
            </p>
            
            <div className="space-y-8">
              {steps.map((step) => (
                <div key={step.id} className="flex items-start gap-5 group p-4 rounded-2xl transition-all duration-300 hover:bg-purple-50/50 hover:translate-x-2 cursor-default">
                  <div className="w-12 h-12 flex-shrink-0 rounded-full bg-[#2D2B3F] flex items-center justify-center font-bold text-white text-xl shadow-lg shadow-purple-900/10 transition-all duration-300 group-hover:scale-110 group-hover:bg-purple-600 group-hover:shadow-purple-600/30">
                    {step.id}
                  </div>
                  <div>
                    <h4 className="text-gray-900 font-bold text-xl mb-2 transition-colors duration-300 group-hover:text-purple-700">{step.title}</h4>
                    <p className="text-gray-600 leading-relaxed">{step.desc}</p>
                  </div>
                </div>
              ))}
            </div>
          </div>
          
          <div className="lg:w-1/2 relative w-full lg:pl-10 perspective-1000">
            <div className="relative bg-[#2D2B3F] p-10 rounded-[2.5rem] shadow-2xl text-white overflow-hidden transform transition-all duration-500 hover:scale-[1.02] hover:-translate-y-2 hover:shadow-purple-900/40 animate-float-slow">
                
                <div className="absolute top-0 right-0 w-64 h-64 bg-purple-600/30 rounded-full blur-3xl -mr-20 -mt-20 animate-pulse-slow"></div>
                <div className="absolute bottom-0 left-0 w-64 h-64 bg-indigo-600/20 rounded-full blur-3xl -ml-20 -mb-20 animate-pulse-slow animation-delay-2000"></div>
                
                <h3 className="text-2xl font-bold mb-6 relative z-10">Játékmenet</h3>
                
                <div className="space-y-6 relative z-10">
                    <div className="bg-white/10 p-4 rounded-xl border border-white/10 flex items-center justify-between transition-colors hover:bg-white/20">
                         <div className="flex flex-col">
                             <span className="text-purple-200 text-sm mb-1 font-medium">Kategória</span>
                             <span className="font-semibold text-lg">Történelem & Tudomány</span>
                         </div>
                         <div className="h-10 w-10 bg-purple-500 rounded-xl flex items-center justify-center text-2xl shadow-lg">🧠</div>
                    </div>

                    <div className="h-36 w-full bg-indigo-900/40 rounded-2xl border border-indigo-700/40 flex flex-col items-center justify-center p-6 text-center transition-colors hover:bg-indigo-900/60">
                        <span className="text-lg font-medium mb-3">Következő kérdés...</span>
                        <div className="w-full h-3 bg-white/10 rounded-full overflow-hidden">
                            <div className="w-2/3 h-full bg-gradient-to-r from-purple-400 to-pink-400 rounded-full animate-pulse"></div>
                        </div>
                    </div>
                </div>
            </div>
          </div>
        </div>
      </div>
    </section>
  );
}

export default HowItWorks;