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
};

module.exports = nextConfig;
