import type { HeaderProps } from "../interfaces/props/HeaderProps";

const Header = ({ title, description }: HeaderProps) => {
    return (
        <header className="w-full py-8 md:py-10">
            <div className="max-w-7xl mx-auto md:mx-0">
                <h1 className="text-2xl md:text-3xl font-bold text-slate-800 tracking-tight">
                    {title}
                </h1>
                {description && (
                    <p className="text-sm md:text-base text-slate-500 mt-2">
                        {description}
                    </p>
                )}
            </div>
        </header>
    );
};

export default Header;