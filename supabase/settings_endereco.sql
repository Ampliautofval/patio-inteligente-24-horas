-- Endereço da empresa para recibo e documentos (Configurações).
alter table if exists settings
  add column if not exists endereco text;
