CREATE DATABASE TESTE;
-- No my sql use teste.carro, ou teste.pessoa como tabela
CREATE TABLE CARRO (placa char(10) primary key, marca char(20) not null, modelo char(20) not null, cor char(20), cilindrada integer);
CREATE TABLE PESSOA(RG char(15) primary key, Nome char(60) not null, Endereco char(120), placa char(10) not null references CARRO(placa));

-- Inserindo valores em Carro.
INSERT INTO CARRO VALUES('45-77-AA','FIAT','Uno', 'Cinzento',1100);
INSERT INTO CARRO VALUES('21-05-EN','OPEL','Astra','Cinzento',1400);
INSERT INTO CARRO VALUES('81-99-HT','Citroen','Xantia','Azul Metalizado',1400);

-- Inserindo valores em Pessoa.
INSERT INTO PESSOA VALUES('12345','Marilia','Rua X','81-99-HT');
INSERT INTO PESSOA VALUES('23456','Cidalia','Rua Y','45-77-AA');
INSERT INTO PESSOA VALUES('34567','Celia','Rua Z','81-99-HT');

-- Executando consultas básicas.
SELECT * FROM PESSOA;
SELECT * FROM CARRO;
SELECT NOME, PLACA FROM PESSOA;
SELECT MARCA,MODELO,CILINDRADA FROM CARRO WHERE CILINDRADA < 1500;

-- Executando consultas mais avancadas.
SELECT * FROM CARRO WHERE COR LIKE 'CINZ%';
SELECT * FROM CARRO WHERE CILINDRADA > 1250 AND MODELO <> 'Uno' AND PLACA LIKE '%1%';
SELECT NOME, CARRO.PLACA, MARCA, MODELO FROM CARRO, PESSOA WHERE CARRO.PLACA = PESSOA.PLACA ORDER BY NOME;
SELECT NOME, CARRO.PLACA, MARCA, MODELO FROM CARRO, PESSOA WHERE CARRO.PLACA = PESSOA.PLACA ORDER BY MARCA DESC, NOME ASC;

-- Contar
SELECT COUNT(*) AS CONTADOR FROM CARRO WHERE CILINDRADA > 1200;
SELECT COR, COUNT(*) AS CONTAGEM FROM CARRO GROUP BY COR;

-- media, mínima, máxima 
select avg(cilindrada) as media, min(cilindrada) as Minimo, max(cilindrada) as Maximo from CARRO;

-- calculo aritimético
SELECT MARCA, MODELO, CILINDRADA, CILINDRADA * 2 AS PRECO FROM CARRO;

-- Consultas aninhadas.
SELECT * FROM CARRO WHERE PLACA NOT IN (SELECT PLACA FROM PESSOA);

--Atualizações
UPDATE PESSOA SET PLACA = '21-05-EN' WHERE PLACA = '45-77-AA';
UPDATE PESSOA SET TM = '961234567' WHERE NOME LIKE '%c%';

-- Funciona apenas no MYSQL.
ALTER TABLE PESSOA ADD COLUMN TM VARCHAR(20);
-- Esse já funciona no Oracle DB e SQL Server
ALTER TABLE PESSOA ADD TM VARCHAR(20);

-- Criando Indices.
CREATE INDEX INOME ON PESSOA(NOME);
CREATE INDEX ICONJUNTO ON PESSOA(RG,PLACA,TM);

-- Apagando as 2 tabelas e o banco de dados.
DROP TABLE PESSOA;
DROP TABLE CARRO;
DROP DATABASE TESTE;