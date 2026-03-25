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
  // / → /app.html é tratado em pages/index.tsx (getServerSideProps). Só atalhos sem .html:
  async redirects() {
    return [{ source: "/app", destination: "/app.html", permanent: false }];
  },
};

module.exports = nextConfig;
