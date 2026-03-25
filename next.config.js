/** @type {import('next').NextConfig} */
const nextConfig = {
  reactStrictMode: true,
  // Evita falha de build na Vercel quando não há páginas React (app usa public/app.html)
  eslint: {
    ignoreDuringBuilds: true,
  },
  typescript: {
    ignoreBuildErrors: true,
  },
  // No celular, a raiz do site deve abrir o app sem depender de JS (evita 404 em /app sem .html)
  async redirects() {
    return [
      { source: "/", destination: "/app.html", permanent: false },
      { source: "/app", destination: "/app.html", permanent: false },
    ];
  },
};

module.exports = nextConfig;
