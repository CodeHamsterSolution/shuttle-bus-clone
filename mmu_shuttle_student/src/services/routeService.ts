import axios from "axios";
import type { ActiveBus } from "../interfaces/models/ActiveBus";
import type { Route } from "../interfaces/models/Route";
import api from "../shared/api";
import { mapActiveBusResponseToActiveBusModel, mapRouteResponseToRouteModel } from "../shared/mappers";
import { DEFAULT_ERROR_MESSAGE, WEB_SOCKET_URL } from "../shared/constants";
import { Client } from "@stomp/stompjs";
import SockJS from "sockjs-client";


export async function fetchRoutes(): Promise<Route[]> {
    try {
        const response = await api.get("/routes/web");
        return response.data.map((r: any) => ({
            ...r,
            isLive: r.live,
            color: r.color
        }));
    } catch (e: unknown) {
        if (axios.isAxiosError(e)) {
            throw new Error(e.response?.data.message ?? DEFAULT_ERROR_MESSAGE);
        }
        throw new Error(DEFAULT_ERROR_MESSAGE);
    }
}

export async function fetchRouteById(id: number): Promise<Route> {

    try {
        const response = await api.get(`/routes/${id}`);
        return mapRouteResponseToRouteModel(response.data);
    } catch (e: unknown) {
        if (axios.isAxiosError(e)) {
            throw new Error(e.response?.data.message ?? DEFAULT_ERROR_MESSAGE);
        }
        throw new Error(DEFAULT_ERROR_MESSAGE);
    }
}

export async function fetchActiveBusesLocation(routeId: number): Promise<ActiveBus[]> {

    try {
        const response = await api.get(`/routes/${routeId}/active`);
        return response.data.map(mapActiveBusResponseToActiveBusModel);
    } catch (e: unknown) {
        if (axios.isAxiosError(e)) {
            throw new Error(e.response?.data.message ?? DEFAULT_ERROR_MESSAGE);
        }
        throw new Error(DEFAULT_ERROR_MESSAGE);
    }
}

export function subscribeToRoute(routeId: number, onUpdate: (message: any) => void, onConnect: () => void, onError: (message: string) => void): () => void {
    const stompClient = new Client({
        webSocketFactory: () => new SockJS(WEB_SOCKET_URL),
        reconnectDelay: 5000,
        onConnect: () => {
            onConnect();
            stompClient.subscribe(`/routes/active_buses/${routeId}`, (message) => {
                onUpdate(message);
            });
        },
        onStompError: (frame) => {
            onError(frame.headers['message'] || 'Lost connection to live tracking.');
        },

        onWebSocketError: () => {
            onError('Live tracking disconnected. Attempting to reconnect...');
        },
        onWebSocketClose: () => {
            onError('Live tracking disconnected. Attempting to reconnect...');
        }
    });

    stompClient.activate();

    return () => {
        if (stompClient.active) {
            stompClient.deactivate();
        }
    };
}