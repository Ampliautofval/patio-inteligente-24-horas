-- Migra ciclos que estavam como «Contas a receber» (EM_ABERTO + period_end preenchido)
-- para AGUARDANDO_LANCAMENTO no Supabase, alinhado ao fluxo pátio → triagem → receber/caixa.
--
-- Pré-requisito: coluna/check de status aceitar AGUARDANDO_LANCAMENTO
-- (ver receivables_aguardando_lancamento.sql).
--
-- Opcional: a app já lista esses registos em «Aguardando lançamento» mesmo sem este UPDATE,
-- usando triagem no browser; este script unifica o estado na base.

UPDATE receivables
SET status = 'AGUARDANDO_LANCAMENTO'
WHERE status = 'EM_ABERTO'
  AND period_end IS NOT NULL;
