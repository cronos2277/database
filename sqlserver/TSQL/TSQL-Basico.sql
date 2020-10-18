-- Exemplo com SET
CREATE TABLE EXEMPLO(
	ID SMALLINT IDENTITY PRIMARY KEY,
	NOME VARCHAR NOT NULL
)

INSERT INTO EXEMPLO (NOME) VALUES ('JOAO')
INSERT INTO EXEMPLO (NOME) VALUES ('MARCIA')
INSERT INTO EXEMPLO (NOME) VALUES ('LUCAS')
INSERT INTO EXEMPLO (NOME) VALUES ('SUZANA')
GO

DECLARE
	@CONTAGEM INT	
BEGIN
	SET @CONTAGEM = (SELECT COUNT(*) FROM DBO.dados_originais)
	PRINT 'Numero de registros: ' + CAST(@CONTAGEM	as VARCHAR)
END
GO


-- Exemplo com SELECT
CREATE TABLE FFSAL(
	ID SMALLINT IDENTITY PRIMARY KEY,
	SALARIO MONEY NOT NULL
)
INSERT INTO FFSAL(SALARIO) VALUES(1000)
INSERT INTO FFSAL(SALARIO) VALUES(2200)
INSERT INTO FFSAL(SALARIO) VALUES(3700)
INSERT INTO FFSAL(SALARIO) VALUES(44000)
GO
DECLARE
	@SOMA MONEY
BEGIN
	SELECT @SOMA = SUM(FFSAL.SALARIO) FROM FFSAL
	PRINT 'SOMA: ' + CAST(@SOMA AS VARCHAR)
END
GO

