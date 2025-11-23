import { Link } from "react-router-dom";
const BG_CLASSES = "bg-[#6e11b0] hover:bg-[#ad46ff]";
const SHADOW_CLASSES = "shadow-lg shadow-purple-900/20";

function Button({
  children,
  to,
  href,
  className = "",
  onClick
}) {
  const baseStyles = `inline-flex items-center justify-center px-6 py-3 text-sm md:text-base font-bold text-white rounded-full transition-all transform hover:-translate-y-0.5 active:scale-95 focus:outline-none ${BG_CLASSES} ${SHADOW_CLASSES}`;
  const combinedClasses = `${baseStyles} ${className}`;

  if (to) {
    return (
      <Link to={to} className={combinedClasses} onClick={onClick}>
        {children}
      </Link>
    );
  }

  if (href) {
    return (
      <a
        href={href}
        className={combinedClasses}
        onClick={onClick}
        target="_blank"
        rel="noopener noreferrer"
      >
        {children}
      </a>
    );
  }

  return (
    <button className={combinedClasses} onClick={onClick}>
      {children}
    </button>
  );
}

export default Button;