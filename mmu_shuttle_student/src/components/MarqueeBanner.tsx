import type { ReactNode } from 'react';

interface MarqueeBannerProps {
    children: ReactNode;
    className?: string;
}

const MarqueeBanner = ({ children, className = '' }: MarqueeBannerProps) => {
    return (
        <div className={`overflow-hidden whitespace-nowrap ${className}`}>
            <div className="inline-flex animate-marquee">
                <span className="inline-flex items-center gap-2 px-4">{children}</span>
                <span className="inline-flex items-center gap-2 px-4">{children}</span>
                <span className="inline-flex items-center gap-2 px-4">{children}</span>
            </div>
        </div>
    );
};

export default MarqueeBanner;
