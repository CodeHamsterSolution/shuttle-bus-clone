import { StrictMode } from 'react'
import { createRoot } from 'react-dom/client'
import './index.css'
import App from './App.tsx'
import { QueryClient, QueryClientProvider } from '@tanstack/react-query'
import { APIProvider } from '@vis.gl/react-google-maps'
import { GOOGLE_MAPS_API_KEY } from './shared/constants.ts'

const queryClient = new QueryClient();

createRoot(document.getElementById('root')!).render(
  <StrictMode>
    <QueryClientProvider client={queryClient}>
      <APIProvider apiKey={GOOGLE_MAPS_API_KEY}>
        <App />
      </APIProvider>
    </QueryClientProvider>
  </StrictMode>,
)
