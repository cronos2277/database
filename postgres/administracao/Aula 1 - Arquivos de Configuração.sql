-- Aula de Arquivos de Configuração

--Esse comando exibe uma lista:
-- name => nome do serviço.
-- context => se postmaster são alterações que precisam de reinicialização completa do Banco de dados, se user não precisa.
-- unit => valor unitário de cada bloco
-- setting, boot_val, reset_val são os valores dos parâmetros dos serviços acima.
SELECT name, context, unit, setting, boot_val, reset_val FROM pg_settings WHERE name IN ( 'listen_addresses', 'max_connections', 'shared_buffers', 'effective_cache_size', 'work_mem', 'maintenance_work_mem') ORDER BY context, name;
-- Mostra o local dos principais arquivos do Postgres.
-- postgressql.conf => controla as configurações gerais do postgres.
-- pg_ident faz mapeamento dos usuários que podem acessar remotamente o BD.
-- pg_hba você define quais IPs e como que podem acessar o seu BD.
SELECT name, setting FROM pg_settings WHERE category = 'File Locations';
