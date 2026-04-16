import { Bus } from 'lucide-react';
import type { BusIconProps } from '../interfaces/props/BusIconProps';
import { useState, useRef, useEffect } from 'react';

const BusIcon = ({ carPlate, alignTooltip = 'center', color = '#113a9f' }: BusIconProps) => {
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
        <div ref={containerRef} className="relative group" onClick={() => setIsOpen(!isOpen)}>
            <div style={{ backgroundColor: color }} className={`flex items-center justify-center w-12 h-12 rounded-full text-white shadow-md cursor-pointer transition-transform group-hover:scale-105 ${isOpen ? 'scale-105' : ''}`}>
                <Bus size={24} strokeWidth={2.5} />
            </div>
            {alignTooltip === 'center' ? (
                <div className={`absolute bottom-full left-1/2 transform -translate-x-1/2 mb-2 px-3 py-1 bg-gray-900 text-white text-sm font-semibold rounded-md shadow-lg whitespace-nowrap z-[100] transition-all duration-200 pointer-events-none after:content-[''] after:absolute after:top-full after:left-1/2 after:-translate-x-1/2 after:border-4 after:border-transparent after:border-t-gray-900 ${activeClass}`}>
                    Plate: {carPlate}
                </div>
            ) : (
                <div className={`absolute top-1/2 left-[100%] transform -translate-y-1/2 ml-2 px-3 py-1 bg-gray-900 text-white text-sm font-semibold rounded-md shadow-lg whitespace-nowrap z-[100] transition-all duration-200 pointer-events-none after:content-[''] after:absolute after:top-1/2 after:right-[100%] after:-translate-y-1/2 after:border-4 after:border-transparent after:border-r-gray-900 ${activeClass}`}>
                    Plate: {carPlate}
                </div>
            )}
        </div>
    );
};

export default BusIcon;