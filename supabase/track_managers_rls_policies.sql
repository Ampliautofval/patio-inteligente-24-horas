-- Políticas RLS para track_managers: permitir ao dono (gestor geral) ler/inserir/atualizar/apagar
-- as suas delegações, e ao gestor delegado ler a própria linha.
-- Executar no SQL Editor do Supabase (uma vez). Ajusta se já tiveres políticas com outros nomes.

ALTER TABLE track_managers ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS track_managers_select_owner_or_delegate ON track_managers;
DROP POLICY IF EXISTS track_managers_insert_owner ON track_managers;
DROP POLICY IF EXISTS track_managers_update_owner ON track_managers;
DROP POLICY IF EXISTS track_managers_delete_owner ON track_managers;

CREATE POLICY track_managers_select_owner_or_delegate
  ON track_managers
  FOR SELECT
  TO authenticated
  USING (auth.uid() = owner_user_id OR auth.uid() = user_id);

CREATE POLICY track_managers_insert_owner
  ON track_managers
  FOR INSERT
  TO authenticated
  WITH CHECK (auth.uid() = owner_user_id);

CREATE POLICY track_managers_update_owner
  ON track_managers
  FOR UPDATE
  TO authenticated
  USING (auth.uid() = owner_user_id)
  WITH CHECK (auth.uid() = owner_user_id);

CREATE POLICY track_managers_delete_owner
  ON track_managers
  FOR DELETE
  TO authenticated
  USING (auth.uid() = owner_user_id);
