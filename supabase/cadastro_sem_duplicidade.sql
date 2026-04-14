-- Executar no SQL Editor do Supabase (projeto correto).
-- Impede duplicidade na base de dados. Se o CREATE INDEX falhar por «duplicate key»,
-- corrija primeiro os registos duplicados existentes e volte a executar.

-- Veículos: mesma placa normalizada (só letras/números, maiúsculas) não pode repetir
-- para o mesmo utilizador enquanto o veículo não estiver REMOVIDO (pode voltar a cadastrar após VRP).
CREATE UNIQUE INDEX IF NOT EXISTS vehicles_user_placa_norm_nao_removido_uidx
ON vehicles (
  user_id,
  upper(regexp_replace(trim(COALESCE(placa, '')), '[^A-Za-z0-9]', '', 'g'))
)
WHERE status IS DISTINCT FROM 'REMOVIDO'
  AND length(regexp_replace(trim(COALESCE(placa, '')), '[^A-Za-z0-9]', '', 'g')) > 0;

-- Parceiros/assessorias: mesmo nome (normalizado) por utilizador e tipo.
CREATE UNIQUE INDEX IF NOT EXISTS partners_user_tipo_nome_norm_uidx
ON partners (
  user_id,
  CAST(COALESCE(tipo, 'PARCEIRO') AS text),
  lower(regexp_replace(btrim(COALESCE(nome, '')), '[[:space:]]+', ' ', 'g'))
)
WHERE length(btrim(COALESCE(nome, ''))) > 0;

-- Parceiros: mesmo documento (CPF/CNPJ, só dígitos, 11 ou mais caracteres) por utilizador.
CREATE UNIQUE INDEX IF NOT EXISTS partners_user_doc_digits_uidx
ON partners (user_id, regexp_replace(COALESCE(cpf, ''), '[^0-9]', '', 'g'))
WHERE length(regexp_replace(COALESCE(cpf, ''), '[^0-9]', '', 'g')) >= 11;
