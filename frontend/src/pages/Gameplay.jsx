import React from 'react';

const Gameplay = () => {
  return (
    <div className="max-w-6xl mx-auto py-16 px-6 font-sans">
      {/* Főcím - Fekete */}
      <header className="text-center mb-20">
        <h1 className="text-6xl font-black text-black mb-6">
          Hogyan válj profivá?
        </h1>
        <p className="text-2xl text-[#4c1d95] font-bold italic">
          Minden eszköz a kezedben van a fejlődéshez – tanuld meg használni őket!
        </p>
      </header>

      {/* Kártyák rácsa */}
      <div className="grid grid-cols-1 md:grid-cols-3 gap-10 items-start">
        
        {/* 1. Kártya */}
        <div className="bg-white rounded-[3rem] p-10 border border-purple-100 text-center hover:-translate-y-2 transition-all duration-500">
          <div className="w-20 h-20 bg-purple-50 rounded-3xl flex items-center justify-center mx-auto mb-8 text-4xl">🔍</div>
          
          {/* Fekete-Lila Átmenetes Cím */}
          <h3 className="text-3xl font-bold mb-6 bg-gradient-to-r from-black to-[#6d28d9] bg-clip-text text-transparent">
            1. Válaszd ki az utad!
          </h3>
          
          <div className="text-[#4c1d95] font-semibold leading-relaxed space-y-4 text-lg">
            <p>
              Navigálj a <span className="text-[#6d28d9] font-black italic">Quizek</span> fülre, ahol kategóriák széles választéka vár a filmektől a kódolás alapjaiig.
            </p>
            <div className="bg-purple-50 p-5 rounded-2xl border border-purple-100 text-left space-y-2 text-base">
              <p className="flex justify-between">
                <span><strong>Könnyű:</strong></span>
                <span className="font-black text-[#6d28d9]">10 mp/kérdés</span>
              </p>
              <p className="flex justify-between">
                <span><strong>Közepes:</strong></span>
                <span className="font-black text-[#6d28d9]">20 mp/kérdés</span>
              </p>
              <p className="flex justify-between">
                <span><strong>Nehéz:</strong></span>
                <span className="font-black text-[#6d28d9]">30 mp/kérdés</span>
              </p>
            </div>
          </div>
        </div>

        {/* 2. Kiemelt Kártya */}
        <div className="bg-white rounded-[3rem] p-10 border-4 border-[#6d28d9] text-center hover:-translate-y-4 transition-all duration-500 relative z-10 scale-105">
          <div className="w-20 h-20 bg-purple-100 rounded-3xl flex items-center justify-center mx-auto mb-8 text-4xl animate-pulse">⏳</div>
          
          {/* Fekete-Lila Átmenetes Cím */}
          <h3 className="text-3xl font-black mb-6 uppercase tracking-tighter bg-gradient-to-r from-black to-[#6d28d9] bg-clip-text text-transparent">
            2. Urald a játékot!
          </h3>
          
          <div className="text-[#4c1d95] font-bold leading-relaxed space-y-4 text-lg">
            <p>
              A kvíz során az <span className="text-[#6d28d9] font-black">Időzítő</span> a legjobb barátod. De vigyázz: amint eléred a <span className="underline text-black">10 mp</span>,-t az óra villogni kezd!
            </p>
            <p className="bg-purple-50 p-5 rounded-2xl border-l-8 border-[#6d28d9]">
              Építs <span className="text-[#6d28d9] font-black">Streak</span> bónuszt! Sorozatos jó válaszokkal megsokszorozhatod a pontjaidat és a tapasztalatot.
            </p>
          </div>
        </div>

        {/* 3. Kártya */}
        <div className="bg-white rounded-[3rem] p-10 border border-purple-100 text-center hover:-translate-y-2 transition-all duration-500">
          <div className="w-20 h-20 bg-purple-50 rounded-3xl flex items-center justify-center mx-auto mb-8 text-4xl">🏆</div>
          
          {/* Fekete-Lila Átmenetes Cím */}
          <h3 className="text-3xl font-bold mb-6 bg-gradient-to-r from-black to-[#6d28d9] bg-clip-text text-transparent">
            3. Építsd a neved!
          </h3>
          
          <div className="text-[#4c1d95] font-semibold leading-relaxed space-y-4 text-lg">
            <p>
              A játék végén az <span className="text-[#6d28d9] font-black italic">Eredmények</span> képernyőn összegezzük a teljesítményedet és a gyűjtött pontokat.
            </p>
            <p>
              Vadászd a ritka elismeréseket! Gyűjts be trófeákat, hirdesd tudásodat a ranglistán, és mutasd meg másoknak is a <span className="text-[#6d28d9] font-black">Profilodon</span>.
            </p>
          </div>
        </div>

      </div>
      
      {/* Footer - Fekete */}
      <footer className="mt-20 text-center">
        <p className="text-black font-black text-2xl uppercase tracking-[0.2em] animate-bounce">
          Irány a Quizek fül, kezdődjön a játék!
        </p>
      </footer>
    </div>
  );
};

export default Gameplay;