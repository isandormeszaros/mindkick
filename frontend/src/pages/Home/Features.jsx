import { FaBrain, FaTrophy, FaMedal } from "react-icons/fa";
const featuresData = [
  {
    icon: <FaBrain className="text-4xl text-purple-800" />,
    title: "Indíts új kvízt",
    desc: "Válassz több tucat kategória közül. Történelem, technológia vagy popkultúra?",
  },
  {
    icon: <FaTrophy className="text-4xl text-purple-800" />,
    title: "Globális Ranglista",
    desc: "Minden helyes válasz pontot ér. Küzdd fel magad a csúcsra és előzd meg a többieket!",
  },
  {
    icon: <FaMedal className="text-4xl text-purple-800" />,
    title: "Szerezz Jelvényeket",
    desc: "Teljesítsd a napi kihívásokat és oldj fel ritka achievementeket a profilodhoz.",
  },
];

function Features() {
  return (
    <section className="py-24 bg-gray-50">
      <div className="max-w-6xl mx-auto px-6">
        <div className="text-center mb-16">
          <h2 className="text-3xl md:text-4xl font-extrabold text-gray-900 mb-4">Miért a MindKick?</h2>
          <p className="text-xl text-gray-600 max-w-2xl mx-auto">Minden eszköz a kezedben van a fejlődéshez, letisztult környezetben.</p>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
          {featuresData.map((item, index) => (
            <div
              key={index}
              className="p-8 bg-white rounded-3xl shadow-sm hover:shadow-xl transition duration-300 group border border-purple-50/50"
            >
              <div className="mb-6 p-4 bg-purple-50 rounded-2xl inline-block group-hover:scale-110 transition duration-300">
                {item.icon}
              </div>
              <h3 className="text-xl font-bold text-gray-900 mb-3">{item.title}</h3>
              <p className="text-gray-600 leading-relaxed">{item.desc}</p>
            </div>
          ))}
        </div>
      </div>
    </section>
  );
}

export default Features;