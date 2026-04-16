import type { Announcement } from "../interfaces/models/Announcement";
import api from "../shared/api";
import axios from "axios";
import { DEFAULT_ERROR_MESSAGE } from "../shared/constants";

export async function fetchAnnouncements(): Promise<Announcement[]> {
    try {
        const response = await api.get("/announcements/all");
        return response.data;
    } catch (e: unknown) {
        if (axios.isAxiosError(e)) {
            throw new Error(e.response?.data.message ?? DEFAULT_ERROR_MESSAGE);
        }
        throw new Error(DEFAULT_ERROR_MESSAGE);
    }
}