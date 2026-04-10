/** @type {import('next').NextConfig} */
const nextConfig = {
  reactStrictMode: true,
  eslint: {
    ignoreDuringBuilds: true,
  },
  typescript: {
    ignoreBuildErrors: true,
  },
  // Rewrites no Next (não só em vercel.json) para a Vercel tratar o projeto como Next.js e servir /api/*.
  async rewrites() {
    return [
      { source: "/", destination: "/app.html" },
      { source: "/app", destination: "/app.html" },
      { source: "/amplipatio", destination: "/app.html" },
      { source: "/patio", destination: "/app.html" },
    ];
  },
  async headers() {
    const noStore = [{ key: "Cache-Control", value: "no-store, must-revalidate" }];
    return [
      { source: "/app.html", headers: noStore },
      { source: "/", headers: noStore },
      { source: "/app", headers: noStore },
      { source: "/amplipatio", headers: noStore },
      { source: "/patio", headers: noStore },
    ];
  },
};

module.exports = nextConfig;
