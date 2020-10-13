CREATE TABLE CONTAS(	
	CONTA INT,
	VALOR INT,
	DEB_CRED CHAR(1)
)
GO

-- No caso eh nesse diretorio que deve estar o arquivo contas.txt, para importacao
-- Mude aqui no FROM se precisar
BULK INSERT CONTAS FROM 'B:\CONTAS.txt'
WITH
(
	FIRSTROW = 2, -- Comeca em qual linha?
	DATAFILETYPE = 'CHAR', -- Tipo de dados encontrado no arquivo aberto
	FIELDTERMINATOR = '\t', -- Aqui definimos um separador de coluna, no caso o TAB.
	ROWTERMINATOR = '\n' -- Aqui definimos um separador de Linha, no caso o Enter.
)
GO

SELECT * FROM CONTAS GO

SELECT CONTA, 
-- Flegando Se for credito multiplica por 1, caso debito multiplique por -1.
SUM(VALOR * (CHARINDEX('C',DEB_CRED) * 2 - 1)) as "SALDO"
FROM CONTAS
GROUP BY CONTA
ORDER BY CONTA
GO

DROP TABLE CONTAS
GO