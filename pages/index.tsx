import type { GetServerSideProps } from "next";

/**
 * Redirecionamento no servidor: no celular não depende de JS (useEffect falhava / tela branca).
 * O app estático fica em /app.html (public/).
 */
export const getServerSideProps: GetServerSideProps = async () => {
  return {
    redirect: {
      destination: "/app.html",
      permanent: false,
    },
  };
};

export default function Home() {
  return null;
}
