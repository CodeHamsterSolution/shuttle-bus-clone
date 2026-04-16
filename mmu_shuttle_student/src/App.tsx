import { BrowserRouter, Route, Routes } from "react-router";
import ViewRoutePage from "./pages/ViewRoutePage";
import HomePage from "./pages/HomePage";
import NotFoundPage from "./pages/NotFoundPage";
import AppBar from "./components/NavBar";

const App = () => {
  return (
    <BrowserRouter>
      <AppBar />

      <Routes>
        <Route path="/" element={<HomePage />} />
        <Route path="/route/:id" element={<ViewRoutePage />} />
        <Route path="*" element={<NotFoundPage />} />
      </Routes>
    </BrowserRouter>
  );
};

export default App;