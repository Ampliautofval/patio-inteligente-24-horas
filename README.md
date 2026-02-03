# AMPLIPATIO (AMPLIAUTO)

Sistema web para gestão de pátio de veículos com cobrança de diárias, controle financeiro e emissão de Nota Fiscal.

## Arquitetura (visão geral)

- **Frontend**: React + TypeScript (Vite)
- **Backend**: Node.js + Express + TypeScript
- **Banco**: PostgreSQL
- **Autenticação**: JWT
- **API**: REST

## Estrutura de pastas (proposta)

```
amplipatio/
  backend/
    src/
      app.ts
      server.ts
      config/
        env.ts
      db/
        pool.ts
        schema.sql
      middleware/
        auth.ts
        role.ts
        error.ts
      modules/
        auth/
        vehicles/
        finance/
        dashboard/
        audit/
      utils/
        feeCalculator.ts
        dates.ts
    package.json
    tsconfig.json
    .env.example
  frontend/
    index.html
    vite.config.ts
    tsconfig.json
    package.json
    src/
      main.tsx
      App.tsx
      api/
        client.ts
      components/
        Layout.tsx
        StatCard.tsx
      pages/
        Login.tsx
        Dashboard.tsx
        Vehicles.tsx
        VehicleEntry.tsx
        VehicleExit.tsx
        Finance.tsx

## Seed inicial

No backend, execute:

```
npm run seed
```

Cria instituições, tipos de veículo, regras de diária e um usuário admin
(senha padrão `admin123`, ou defina `ADMIN_PASSWORD` no ambiente).

Seed SQL (alternativo):

```
psql "$DATABASE_URL" -f backend/src/db/seed.sql
```
```
# Amplipatio

Sistema de **gerenciamento de pátio** para controle de veículos, vagas e movimentações em tempo real.

## Funcionalidades

- **Dashboard** – Visão geral: total de vagas, ocupadas, livres e veículos no pátio
- **Pátio** – Mapa visual de vagas por setor (A, B) com status (livre, ocupada, reservada, manutenção)
- **Veículos** – Listagem de veículos no pátio com placa, tipo, motorista, transportadora e vaga
- **Relatórios** – Métricas de entradas/saídas e histórico de movimentações (com opção de exportar)

## Tecnologias

- **Next.js 14** (App Router)
- **TypeScript**
- **Tailwind CSS**
- **Lucide React** (ícones)

## Como rodar

```bash
cd amplipatio
npm install
npm run dev
```

Acesse [http://localhost:3000](http://localhost:3000).

## Estrutura do projeto

```
amplipatio/
├── app/              # Páginas e layout (Next.js App Router)
├── components/       # Componentes reutilizáveis (ex.: Sidebar)
├── lib/              # Dados mock e utilitários
├── types/            # Tipos TypeScript (Vaga, Veiculo, Movimentacao)
└── package.json
```

## Próximos passos sugeridos

- Persistência em banco (ex.: SQLite, PostgreSQL)
- API REST para CRUD de vagas, veículos e movimentações
- Registro de entrada/saída com formulários
- Filtros e busca na listagem de veículos
- Autenticação de usuários
- Exportação real (CSV/PDF) em Relatórios

---

**Amplipatio** – Gerenciamento de pátio simplificado.
