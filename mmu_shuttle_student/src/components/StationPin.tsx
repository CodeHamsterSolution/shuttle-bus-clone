import { useState, useRef, useEffect } from "react";
import type { StationPinProps } from "../interfaces/props/StationPinProps";

const StationPin = ({ name, sequence }: StationPinProps) => {
    const isFirst = sequence === 0;
    const [isOpen, setIsOpen] = useState(false);
    const containerRef = useRef<HTMLDivElement>(null);

    useEffect(() => {
        const handleClickOutside = (event: MouseEvent | TouchEvent) => {
            if (containerRef.current && !containerRef.current.contains(event.target as Node)) {
                setIsOpen(false);
            }
        };

        if (isOpen) {
            document.addEventListener('mousedown', handleClickOutside);
            document.addEventListener('touchstart', handleClickOutside);
        }

        return () => {
            document.removeEventListener('mousedown', handleClickOutside);
            document.removeEventListener('touchstart', handleClickOutside);
        };
    }, [isOpen]);

    const activeClass = isOpen ? 'opacity-100 visible' : 'opacity-0 invisible group-hover:opacity-100 group-hover:visible';

    return (
        <div ref={containerRef} className={`relative group cursor-pointer ${isFirst ? 'z-20' : 'z-10'}`} onClick={() => setIsOpen(!isOpen)}>
            <div className={`flex items-center justify-center rounded-full border-white transition-transform duration-300 group-hover:scale-125 ${isOpen ? 'scale-125' : ''} ${
                isFirst
                    ? "w-[28px] h-[28px] bg-[#f97316] border-[4px] shadow-lg"
                    : "w-[22px] h-[22px] bg-[#113a9f] border-[3px] shadow-md"
                }`}></div>

            <div className={`absolute bottom-full left-1/2 transform -translate-x-1/2 mb-1.5 px-3 py-1 bg-gray-900 text-white text-sm font-semibold rounded-md shadow-lg whitespace-nowrap z-[100] transition-all duration-200 pointer-events-none after:content-[''] after:absolute after:top-full after:left-1/2 after:-translate-x-1/2 after:border-4 after:border-transparent after:border-t-gray-900 ${activeClass}`}>
                {name}
            </div>
        </div>
    );
};

export default StationPin;
