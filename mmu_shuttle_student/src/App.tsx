import { BrowserRouter, Route, Routes, useLocation } from "react-router";
import ViewRoutePage from "./pages/ViewRoutePage";
import HomePage from "./pages/HomePage";
import NotFoundPage from "./pages/NotFoundPage";
import AppBar from "./components/NavBar";

const AppLayout = () => {
  const location = useLocation();
  const hideNavbar = location.pathname.startsWith('/route/');

  return (
    <>
      {!hideNavbar && <AppBar />}

      <Routes>
        <Route path="/" element={<HomePage />} />
        <Route path="/route/:id" element={<ViewRoutePage />} />
        <Route path="*" element={<NotFoundPage />} />
      </Routes>
    </>
  );
};

const App = () => {
  return (
    <BrowserRouter>
      <AppLayout />
    </BrowserRouter>
  );
};

export default App;