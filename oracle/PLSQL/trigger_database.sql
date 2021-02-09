-- Criando tabela e sequencia
create table logs (id int primary key, usuario varchar(20), acao char(3), horario date);
create sequence log_seq;

-- Criando Triggers
CREATE OR REPLACE TRIGGER LOG_AFTER
AFTER LOGON ON DATABASE
BEGIN
    insert into logs values(log_seq.nextval,user,'IN',sysdate);
END LOG_AFTER;

CREATE OR REPLACE TRIGGER LOG_BEFORE
BEFORE LOGOFF ON DATABASE
BEGIN
    insert into logs values(log_seq.nextval,user,'OUT',sysdate);
END LOG_BEFORE;


-- Projetando tabela.
SELECT * FROM LOGS;