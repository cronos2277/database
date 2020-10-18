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

## Desvio Condicional
[Desvio Condicional exemplo](Condicional.sql)
### Código
	DECLARE
	    @CONDICAO INT = 0
    BEGIN
        IF @CONDICAO = 0
            PRINT 'ZERO'
        ELSE IF @CONDICAO > 0
            PRINT 'MAIOR QUE ZERO'
        ELSE
            PRINT 'MENOR QUE ZERO'
    END
    GO

### Explicando
Funciona como de maneira semelhante *Pascal*, você pode usar o *if*, *else if* e o *else*. Lembrando, como tem apenas uma instrução, logo não se faz necessário colocar um bloco `BEGIN` ou `END`, mas se houver mais de uma instrução dentro do laço, se faz necessário colocar esse bloco.

## Laço de Repetição
[Arquivo Exemplo](Lacos.sql)
### Código
    DECLARE 
        @CONTADOR INT = 105,
        @DATA DATETIME = '20200702'
    BEGIN
        WHILE @CONTADOR < 123
            BEGIN
                IF (@CONTADOR < 115 OR @CONTADOR >119) AND (@CONTADOR != 122 AND @CONTADOR != 123)
                    PRINT 'DATA: '+CONVERT(VARCHAR,@DATA,@CONTADOR)
                SET @CONTADOR = @CONTADOR + 1
            END
    END
    GO

### Explicando
Aqui temos um exemplo com o laço while, que tem uma sintaxe semelhante a uma linguagem prodecural, no caso `while (condição booleana)`, caso tenha apenas uma instrução o envolver em um bloco `BEGIN` e `END` é opcional, porém para mais instruções, deve usar. Repare que o if por exemplo não tem um bloco `IF (@CONTADOR < 115 OR @CONTADOR >119) AND (@CONTADOR != 122 AND @CONTADOR != 123)`, e repare também que na questão dos operadores não deixa a desejar em frente a linguagem pascal por exemplo, logo os operadores são iguais a uma linguagem de programação.

## Atribuição com SET.
No caso usamos o **SET** como operador de atribuição, diferente das linguagens procedurais, que não usam essa palavra em frente das variáveis, aqui no caso estamos fazendo uma atribuição `SET @CONTADOR = @CONTADOR + 1`, no caso incrementando em 1, não esqueça do `SET` quando for fazer atribuições no `T-SQL`.

## CONVERT E CAST
O `CONVERT` assim como o `CAST` eles alteram o tipo da variável, o `CONVERT` é igual ao cast se diferenciando apenas na conversão de datas, ao qual permite a passagem de um terceiro parametro para a formatação da data, diferente do `CAST`, com ele você já pode formatar data na conversão: `CONVERT(VARCHAR,@DATA,@CONTADOR)` O primeiro parametro é o tipo de dado de saída, no caso queremos que a saída seja um `VARCHAR`, o segundo parametro é a varíavel ou a data literal, e por fim um código de conversão, no caso com base no código dessa [tabela aqui](https://docs.microsoft.com/pt-br/sql/t-sql/functions/cast-and-convert-transact-sql?view=sql-server-ver15) é formatado a data de saída, caso esteja fazendo uma conversão de datas.