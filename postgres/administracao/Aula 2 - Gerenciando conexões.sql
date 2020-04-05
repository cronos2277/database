-- Aula - Gerenciando conexões

-- Informa detalhes sobre as query digitadas no banco.
SELECT * FROM pg_stat_activity;
-- cancela uma conexao, troque o PID pelo processo ID correspondente.
SELECT pg_cancel_backend(pid);
-- finaliza uma conexao, troque o PID pelo processo ID correspondente.
SELECT pg_terminate_backend(pid);
-- Agora com a clausura where, algum role substitua pelo dado correspondente.
SELECT pg_terminate_backend(pid) FROM pg_stat_activity WHERE usename = 'algum_role';
-- No PostGres temos USERNAME, GROUP e Role, o role pode se comportar tanto como um grupo assim como um usuário, 
-- ele seria a versao modenizada para ambos, nas versões mais novas do PostGres.