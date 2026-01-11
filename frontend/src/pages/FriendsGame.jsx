import React from 'react';

const FriendsGame = () => {
  return (
    <div className="flex items-center justify-center min-h-[70vh] px-6">
      <div className="bg-white rounded-[3rem] p-12 border-4 border-[#6d28d9] text-center max-w-2xl transform hover:scale-105 transition-all duration-500">
        <div className="w-24 h-24 bg-purple-50 rounded-3xl flex items-center justify-center mx-auto mb-8 text-5xl animate-bounce">
          🚀
        </div>
        
        <h1 className="text-4xl font-black text-[#6d28d9] mb-4 uppercase tracking-tight">
          Fejlesztés alatt...
        </h1>
        
        <p className="text-xl text-[#4c1d95] font-semibold italic">
          Gőzerővel dolgozunk rajta! Hamarosan hívhatod a barátaidat egy közös MindKick csatára.
        </p>

        <div className="mt-8 h-3 w-full bg-purple-50 rounded-full overflow-hidden border border-purple-100">
          <div className="h-full bg-[#6d28d9] w-2/3 animate-pulse"></div>
        </div>
      </div>
    </div>
  );
};

export default FriendsGame;