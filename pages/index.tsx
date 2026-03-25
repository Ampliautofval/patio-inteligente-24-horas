import { useEffect } from "react";

/**
 * Raiz do site: o app principal está em /app.html (estático em public/).
 */
export default function Home() {
  useEffect(() => {
    window.location.replace("/app.html");
  }, []);
  return null;
}
