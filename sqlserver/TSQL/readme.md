# TSQL

## DECLARE
Nesse bloco declara variável.

## BEGIN
Indica o ínicio de um bloco

## END
Indica o fim de um bloco.

## GO
Quando usado indica um batch, ou seja o SQL Server executa tudo como um bloco, o **GO** deve estar após o **END**, separado de outras queries SQL.

## SET
[Exemplo básico](TSQL-Basico.sql)
### Código
    DECLARE
	    @CONTAGEM INT	
    BEGIN
        SET @CONTAGEM = (SELECT COUNT(*) FROM DBO.dados_originais)
        PRINT 'Numero de registros: ' + CAST(@CONTAGEM	as VARCHAR)
    END
    GO
### Explicando
no bloco `DECLARE` é definido as variáveis, e dentro do `BEGIN` e `END` você tem toda a lógica dentro. Já o `SET` é usado para atribuir um único valor para dentro da variável. A estrutura é `SET @var = (SELECT)`, lembrando que o `SELECT` deve retornar apenas um valor, nesse exemplo acima, temos que `SET @CONTAGEM` recebe o valor de `(SELECT COUNT(*) FROM DBO.dados_originais)`.

## SELECT
[Exemplo básico](TSQL-Basico.sql)
### Código
    DECLARE
	    @SOMA MONEY
    BEGIN
        SELECT @SOMA = SUM(FFSAL.SALARIO) FROM FFSAL
        PRINT 'SOMA: ' + CAST(@SOMA AS VARCHAR)
    END
    GO

### Explicando
No caso do **SELECT** a forma de atribuição se faz de outra maneira, no caso atribuindo uma variável o resultado de uma coluna, como no caso `SELECT @SOMA = SUM(FFSAL.SALARIO) FROM FFSAL`, a atribuição ocorre no meio da clausura **SELECT** `@SOMA = SUM(FFSAL.SALARIO)`.