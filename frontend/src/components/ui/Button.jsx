import { Link } from "react-router-dom";

const DEFAULT_BG = "bg-[#6e11b0] hover:bg-[#ad46ff]";
const SHADOW_CLASSES = "shadow-lg shadow-purple-900/20";

function Button({
  children,
  to,
  href,
  className = "",
  ...props
}) {

  const hasCustomBg = className.includes("bg-");
  const bgClasses = hasCustomBg ? "" : DEFAULT_BG;


  const baseStyles = `inline-flex items-center justify-center px-6 py-3 text-sm md:text-base font-bold text-white rounded-xl transition-all transform hover:-translate-y-0.5 active:scale-95 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-purple-500 disabled:opacity-50 disabled:cursor-not-allowed ${bgClasses} ${SHADOW_CLASSES}`;
  
  const combinedClasses = `${baseStyles} ${className}`;

  if (to) {
    return (
      <Link to={to} className={combinedClasses} {...props}>
        {children}
      </Link>
    );
  }

  if (href) {
    return (
      <a
        href={href}
        className={combinedClasses}
        target="_blank"
        rel="noopener noreferrer"
        {...props} 
      >
        {children}
      </a>
    );
  }


  return (
    <button className={combinedClasses} {...props}>
      {children}
    </button>
  );
}

export default Button;