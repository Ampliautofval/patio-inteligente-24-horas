-- Executar uma vez no SQL Editor do Supabase (projeto correto).
-- Remoção solicitada é independente do status de liberação; remoção efetivada (VRP) exige liberação confirmada + esta flag.

ALTER TABLE vehicles ADD COLUMN IF NOT EXISTS remocao_solicitada boolean NOT NULL DEFAULT false;
ALTER TABLE vehicles ADD COLUMN IF NOT EXISTS remocao_solicitada_por text;
ALTER TABLE vehicles ADD COLUMN IF NOT EXISTS remocao_solicitada_em timestamptz;

COMMENT ON COLUMN vehicles.remocao_solicitada IS 'True quando alguém registrou solicitação de remoção (antes ou depois da liberação confirmada).';
COMMENT ON COLUMN vehicles.remocao_solicitada_por IS 'Nome de quem solicitou a remoção.';
COMMENT ON COLUMN vehicles.remocao_solicitada_em IS 'Momento do registro da solicitação de remoção.';
