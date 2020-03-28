-- conexão ao banco Oracle: sqlplus system/senha => aonde está system você pode colocar um outro nome de user.
-- ou sqlplus system/senha@NOMEDOBANCO => Por padrao o oracle abre o banco de dados informado na var, ORACLE_SID
-- ou sqlplus system/senha@NOMEDOBANCO as sysdba => com o esse "as sysdba", você entra como uma espécie de Root
-- Mostra o nome do usuário.
SHOW USER;

-- Tabela DAMMY, diferente dos outros bancos de dados, o oracle exige que
-- todo comando SELECT venha de uma tabela, porém como o exemplo abaixo:
-- SELECT 1 + 1; no mysql isso funcionaria, mas não do oracle, isso porque
-- todas as consultas com o SELECT exigem uma tabela, nesse caso usamos a 
-- tabela DUMMY que é a DUAL, ficando:
SELECT 1 + 1 FROM DUAL;
-- voce tambem pode dar nome ao resultado:
SELECT 1 + 1 as SOMA FROM DUAL;
-- verificando ambiente
-- Se você encontrar:
-- B023 no meio do resultado -> 32 bits.
-- B047 no meio do resultado -> 64 bits.
-- procure no resultado, se encontrar alguns do caracter acima, ja sabe.
SELECT METADATA FROM SYS.KOPM$;
-- Dicionário de dados
SELECT * FROM DICT;
-- Detalhe: Tudo que tiver v$ => significa que é uma tabela de view do oracle.
-- Você está usando Paralelismo?
SELECT PARALLEL FROM V$INSTANCE;
-- Verificar estruturas de memória.
SELECT COMPONENT, CURRENT_SIZE, MIN_SIZE, MAX_SIZE FROM V$SGA_DYNAMIC_COMPONENTS;
-- Verifica qual banco de dados estou conectado:
SELECT NAME FROM V$DATABASE;
-- Versão do banco de dados:
SELECT BANNER FROM V$VERSION;
-- Verificar privilégios
SELECT * FROM USER_SYS_PRIVS;
-- Tabelas do usuário
SELECT TABLE_NAME FROM USER_TABLES;