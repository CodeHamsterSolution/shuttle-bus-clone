import api from "../shared/api";
import axios from "axios";

export async function viewImage(fileName: string) {
    try {
        const response = await api.get(`/file/${fileName}`, { responseType: 'blob' });
        const blobUrl = window.URL.createObjectURL(response.data);
        window.open(blobUrl, '_blank');
        setTimeout(() => window.URL.revokeObjectURL(blobUrl), 10000);

    } catch (e: unknown) {
        if (axios.isAxiosError(e)) {
            console.error("Failed to load image. Status:", e.response?.status);
            alert("Sorry, this image could not be found or failed to load.");
        } else {
            console.error("Unexpected error:", e);
            alert("A network error occurred.");
        }
    }
}