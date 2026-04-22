import { useRef, useState, useCallback, useEffect } from 'react';
import type { DraggableBottomSheetProps } from '../interfaces/props/DraggableBottomSheetProps';
import { SNAP_POINTS, DEFAULT_SNAP_INDEX } from '../shared/constants';


const DraggableBottomSheet = ({ children }: DraggableBottomSheetProps) => {
    const sheetRef = useRef<HTMLDivElement>(null);
    const isDragging = useRef(false);
    const startY = useRef(0);
    const startHeight = useRef(0);
    const [isAnimating, setIsAnimating] = useState(true);

    const [sheetHeight, setSheetHeight] = useState(() => {
        return window.innerHeight * SNAP_POINTS[DEFAULT_SNAP_INDEX];
    });

    useEffect(() => {
        const handleResize = () => {
            setSheetHeight(prev => {
                const currentFraction = prev / window.innerHeight;
                const closest = SNAP_POINTS.reduce((a, b) =>
                    Math.abs(b - currentFraction) < Math.abs(a - currentFraction) ? b : a
                );
                return window.innerHeight * closest;
            });
        };
        window.addEventListener('resize', handleResize);
        return () => window.removeEventListener('resize', handleResize);
    }, []);

    const snapToNearest = useCallback((currentHeight: number) => {
        const vh = window.innerHeight;
        const fraction = currentHeight / vh;
        let closestSnap = SNAP_POINTS[0];
        let minDist = Math.abs(fraction - closestSnap);

        for (let i = 1; i < SNAP_POINTS.length; i++) {
            const dist = Math.abs(fraction - SNAP_POINTS[i]);
            if (dist < minDist) {
                minDist = dist;
                closestSnap = SNAP_POINTS[i];
            }
        }

        setSheetHeight(vh * closestSnap);
    }, []);

    const handleDragStart = useCallback((clientY: number) => {
        isDragging.current = true;
        setIsAnimating(false);
        startY.current = clientY;
        startHeight.current = sheetHeight;

        document.body.style.userSelect = 'none';
        document.body.style.webkitUserSelect = 'none';
    }, [sheetHeight]);

    const handleDragMove = useCallback((clientY: number) => {
        if (!isDragging.current) return;

        const deltaY = startY.current - clientY; // positive = dragging up
        const newHeight = startHeight.current + deltaY;

        const vh = window.innerHeight;
        const minHeight = vh * (SNAP_POINTS[0] - 0.05);
        const maxHeight = vh * (SNAP_POINTS[SNAP_POINTS.length - 1] + 0.05);
        const clamped = Math.max(minHeight, Math.min(maxHeight, newHeight));

        setSheetHeight(clamped);
    }, []);

    const handleDragEnd = useCallback(() => {
        if (!isDragging.current) return;
        isDragging.current = false;
        setIsAnimating(true);

        document.body.style.userSelect = '';
        document.body.style.webkitUserSelect = '';

        snapToNearest(sheetHeight);
    }, [sheetHeight, snapToNearest]);

    // Touch handlers
    const onTouchStart = useCallback((e: React.TouchEvent) => {
        handleDragStart(e.touches[0].clientY);
    }, [handleDragStart]);

    const onTouchMove = useCallback((e: React.TouchEvent) => {
        handleDragMove(e.touches[0].clientY);
    }, [handleDragMove]);

    const onTouchEnd = useCallback(() => {
        handleDragEnd();
    }, [handleDragEnd]);

    // Mouse handlers
    const onMouseDown = useCallback((e: React.MouseEvent) => {
        e.preventDefault();
        handleDragStart(e.clientY);
    }, [handleDragStart]);

    useEffect(() => {
        const onMouseMove = (e: MouseEvent) => handleDragMove(e.clientY);
        const onMouseUp = () => handleDragEnd();

        window.addEventListener('mousemove', onMouseMove);
        window.addEventListener('mouseup', onMouseUp);

        return () => {
            window.removeEventListener('mousemove', onMouseMove);
            window.removeEventListener('mouseup', onMouseUp);
        };
    }, [handleDragMove, handleDragEnd]);

    return (
        <div
            ref={sheetRef}
            className="md:hidden absolute bottom-0 left-0 right-0 z-20 bg-white rounded-t-2xl shadow-[0_-4px_24px_rgb(0,0,0,0.08)] flex flex-col overflow-hidden"
            style={{
                height: `${sheetHeight}px`,
                transition: isAnimating ? 'height 0.3s cubic-bezier(0.25, 1, 0.5, 1)' : 'none',
            }}
        >
            <div
                className="flex items-center justify-center pt-3 pb-2 cursor-grab active:cursor-grabbing shrink-0 touch-none"
                onTouchStart={onTouchStart}
                onTouchMove={onTouchMove}
                onTouchEnd={onTouchEnd}
                onMouseDown={onMouseDown}
            >
                <div className="w-10 h-1 rounded-full bg-gray-300" />
            </div>

            <div className="flex-1 overflow-y-auto overscroll-contain">
                {children}
            </div>
        </div>
    );
};

export default DraggableBottomSheet;
