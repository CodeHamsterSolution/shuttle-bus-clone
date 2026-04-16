import type { Route } from "../models/Route";

export interface RouteCardProps {
    route: Route;
    indicatorColor: string;
    onClick: () => void;
}