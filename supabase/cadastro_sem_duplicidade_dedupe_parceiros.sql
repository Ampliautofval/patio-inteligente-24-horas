-- Executar ANTES de criar os índices em cadastro_sem_duplicidade.sql
-- se aparecer ERRO 23505 (chave duplicada) em partners.
--
-- Mantém o parceiro com o menor id em cada grupo (mesmo user_id + tipo + nome normalizado)
-- e apaga os restantes, depois de apontar veículos para o id mantido.

BEGIN;

-- Grupo: utilizador + tipo + nome normalizado (igual ao índice exclusivo)
WITH grp_nome AS (
  SELECT
    id,
    MIN(id) OVER (
      PARTITION BY
        user_id,
        CAST(COALESCE(tipo, 'PARCEIRO') AS text),
        lower(regexp_replace(btrim(COALESCE(nome, '')), '[[:space:]]+', ' ', 'g'))
    ) AS keeper_id
  FROM partners
  WHERE length(btrim(COALESCE(nome, ''))) > 0
)
UPDATE vehicles v
SET localizador_id = g.keeper_id
FROM grp_nome g
WHERE v.localizador_id = g.id
  AND g.id <> g.keeper_id;

WITH grp_nome AS (
  SELECT
    id,
    MIN(id) OVER (
      PARTITION BY
        user_id,
        CAST(COALESCE(tipo, 'PARCEIRO') AS text),
        lower(regexp_replace(btrim(COALESCE(nome, '')), '[[:space:]]+', ' ', 'g'))
    ) AS keeper_id
  FROM partners
  WHERE length(btrim(COALESCE(nome, ''))) > 0
)
UPDATE vehicles v
SET assessoria_id = g.keeper_id
FROM grp_nome g
WHERE v.assessoria_id = g.id
  AND g.id <> g.keeper_id;

WITH grp_nome AS (
  SELECT
    id,
    MIN(id) OVER (
      PARTITION BY
        user_id,
        CAST(COALESCE(tipo, 'PARCEIRO') AS text),
        lower(regexp_replace(btrim(COALESCE(nome, '')), '[[:space:]]+', ' ', 'g'))
    ) AS keeper_id
  FROM partners
  WHERE length(btrim(COALESCE(nome, ''))) > 0
)
DELETE FROM partners p
USING grp_nome g
WHERE p.id = g.id
  AND g.id <> g.keeper_id;

-- Mesmo critério do índice por documento (11+ dígitos), se ainda houver duplicados
WITH grp_doc AS (
  SELECT
    id,
    MIN(id) OVER (
      PARTITION BY user_id, regexp_replace(COALESCE(cpf, ''), '[^0-9]', '', 'g')
    ) AS keeper_id
  FROM partners
  WHERE length(regexp_replace(COALESCE(cpf, ''), '[^0-9]', '', 'g')) >= 11
)
UPDATE vehicles v
SET localizador_id = g.keeper_id
FROM grp_doc g
WHERE v.localizador_id = g.id
  AND g.id <> g.keeper_id;

WITH grp_doc AS (
  SELECT
    id,
    MIN(id) OVER (
      PARTITION BY user_id, regexp_replace(COALESCE(cpf, ''), '[^0-9]', '', 'g')
    ) AS keeper_id
  FROM partners
  WHERE length(regexp_replace(COALESCE(cpf, ''), '[^0-9]', '', 'g')) >= 11
)
UPDATE vehicles v
SET assessoria_id = g.keeper_id
FROM grp_doc g
WHERE v.assessoria_id = g.id
  AND g.id <> g.keeper_id;

WITH grp_doc AS (
  SELECT
    id,
    MIN(id) OVER (
      PARTITION BY user_id, regexp_replace(COALESCE(cpf, ''), '[^0-9]', '', 'g')
    ) AS keeper_id
  FROM partners
  WHERE length(regexp_replace(COALESCE(cpf, ''), '[^0-9]', '', 'g')) >= 11
)
DELETE FROM partners p
USING grp_doc g
WHERE p.id = g.id
  AND g.id <> g.keeper_id;

COMMIT;
