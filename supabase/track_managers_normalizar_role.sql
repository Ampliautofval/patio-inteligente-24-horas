-- Correr no SQL Editor se já aplicaste track_managers_role.sql e tens linhas com OPERADOR_CADASTRO.
-- Idempotente: em bases sem esse valor, não altera nada.

UPDATE track_managers
SET role = 'GESTOR_PISTA'
WHERE role = 'OPERADOR_CADASTRO';
