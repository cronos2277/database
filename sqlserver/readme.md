# SQL Server

## Clausura GO
O SQL Server por padrão funciona de maneira assincrona, além disso ele executa o bloco mais rápido primeiro, se voce enviar um comando para criar um banco de dados e outro para usar o banco de dados, será executado sempre o comando de usar, antes mesmo do comando de criar, mesmo que o comando de criação venha antes, isso ocorre porque o SQL server executa sempre o comando mais rápido primeiro, no caso com a clausura GO, você faz o banco de dados se comportar da maneira tradicional, executando o comando na ordem que você digitou. Ou seja com o GO todos aqueles comando viram um bloco e ele executa todo aquele bloco até o GO como qualquer outro banco de dados, porém na sua ausencia ele executa os comandos de maneira assincrona e priorizando os comandos mais rápidos primeiro.

[Arquivo Basico e comparando com o MySql](SQLServer_Query.sql)

## Tipo de dados
### Identity
Esse marcador é equivalente ao *auto_increment* do mysql, porem ele aceita parâmetro, se não hou ver parâmetro, como por exemplo `id int primary key identity`, nesse caso ele funciona de maneira equivalente ao auto_increment e aumenta em um em um partindo do valor 1. Nesse exemplo `id int primary key identity(1,1)`, nesse caso inicia-se do um e incrementa um, no caso com o identity, é possível definir o número de início e a forma de incremento.

### Datas
[Exemplo com datas](datas.sql)

As datas no SQL server funcionam parecido como outros banco de dados, podendo variar o formato de acordo com as configurações do sistema operacional, as funções básicas são:
#### Funções básicas de datas

`DATEDIFF` =>  Faz calculos com datas, a função exige três parâmetro: Primeiro parâmetro é **o que vai ser calculado?**, como opções você tem: `DAY` para calcular dias, `MONTH` para calcular meses e por fim `YEAR` para calcular ano, por exemplo. O segundo parâmetro, assim como o terceiro são duas datas a serem comparadas, essa função retorna um valor inteiro, zero se as duas datas forem iguais, negativo se a segunda data estiver ao futuro da terceira e por fim um numero positivo se a data no terceiro parâmetro estiver ao futuro da data do segundo parâmetro.

`DATENAME` => Retorna em String o dia, mês ou ano daquela data. Por exemplo se você pedir para retornar o mês, a função retorna o nome do mês. O primeiro parametro é o que você quer pegar, `DAY`,`MONTH`,`WEEKDAY`, `YEAR` por exemplo, e o segundo parâmetro é a data ao qual a função deve extrair o dado.

`DATEPART` => tem a mesma lógica que a `DATENAME`, porém diferente dessa retorna um inteiro, ou seja se você pedir para retornar um mês, a função vai retornar um número de 1 a 12 de acordo com o mês.

`DATEADD` => Faz operações com datas, o primeiro parametro deve ser o que você quer calcular, por exemplo: `DAY`,`MONTH`,`WEEKDAY`, `YEAR`. O segundo argumento é o operando, se o número for positivo soma, se for negativo subtrai a data atual, o terceiro e ultimo parametro é a data a ser analisada.

## Funções do Sistema
`select getdate()` => Pega a hora atual, o ano ao segundo.

`cast('valor' as [TYPE])` => Converte o valor para o tipo de dado informado em `[TYPE]`.

`isnull(null,'Valor Nulo')` => Equivalente ao **ifnull** do *mysql*, aonde está num você deve colocar a coluna e caso haja algum valor nulo, ao invés de exibir **NULL** será exibido o valor que você digitar ali no segundo parametro.

`CHARINDEX('[Oque]',[onde],[apartir de])` => Essa função procura uma determinado valor de dentro de uma string e retorna a posição, por exemplo: `CHARINDEX('a',nome)`, nesse exemplo será procurado pelo caracter `'a'`  dentro da coluna `nome`, no é retornado a primeira posição aonde foi encontrado, seria parecido com uma expressão regular, mas sem as flags global e multiline e apenas com a flag ignore case. Em resumo essa função no valor `Ana` por exemplo retornaria o valor **1**, uma vez que a primeira ocorrência dessa String está na posição 1, um outro exemplo seria a String `Joao`, nesse caso retornaria **3** devido a posição do que está sendo procurado. O terceito e ultimo parametro é opcional e informa apartir de qual posição deve ser efetuado a busca, por exemplo `CHARINDEX('a',nome,2)`, nesse caso na String `Ana` será retornado a posição **3**, que é a primeira ocorrência após a posição 2, lembrando que isso altera apenas a busca mas não o resultado, repare que a função, mesmo começando da posição **2**, considera a posição **1** no retorno do resultado, o que explica o valor **3** ao invés de **2**. 
[Arquivo Exemplo](charindex.sql)

#### Projetando data no padrão Brasileiro
[Exercicio](Exercicio%20data%20SQL-Server.sql)
##### Montando a query
    select cast(
            day(aniversario) as varchar) + '/' 
            + cast(month(aniversario) as varchar) + '/' 
            + cast(year(aniversario) as varchar)
    as 'Data de Aniversario' from exemplo_data
    GO
##### Explicando    
No caso você pode projetar uma data usando a função cast, no caso a função `day`, `month`, `year` retornam valores inteiros, logo não tem como fazer uma operação com o `'/'`, logo se faz necessário converter a data para o mesmo tipo, no vaso um *varchar* por isso o `as varchar`.

## Procedimentos do Sistema
`SP_Help [tabela]` => Mostra todas  as informações de `[tabela]`.

`SP_Columns [tabela]` => Mostra as informações detalhadas de todas as colunas de `[tabela]`.

`SP_HELPTEXT [nome do objeto]` => Esse procedimento mostra a query por de trás do `[nome do objeto]`, podendo ser uma tabela, trigger, funcção e etc... Esse procedimento mostra isso de maneira textual e em forma de tabela.

### Observação
Procedimento não contém parenteses, por exemplo os procedimentos com a tabela **exemplo** ficaria assim: `SP_HELP exemplo`, geralmente os procedimentos tem **SP** na frente, que significa **Storage Procedure**, já as funções precisam de parenteses, cuidado para não confundir.

## Importando dados de Arquivo Externo Bulk insert
[exemplo de bulk insert](bulk-insert.sql)

[Arquivo com dados](CONTAS.txt)

### Sintaxe
    BULK INSERT CONTAS FROM 'B:\CONTAS.txt'
    WITH
    (
        FIRSTROW = 2, -- Comeca em qual linha?
        DATAFILETYPE = 'CHAR', -- Tipo de dados encontrado no arquivo aberto
        FIELDTERMINATOR = '\t', -- Aqui definimos um separador de coluna, no caso o TAB.
        ROWTERMINATOR = '\n' -- Aqui definimos um separador de Linha, no caso o Enter.
    )
    GO
### Explicando...
Repare que a sintaxe é parecida com a seleção de uma tabela `BULK INSERT CONTAS FROM 'B:\CONTAS.txt'`, porém trocamos o **where** por **with**, aqui definimos o local do arquivo que deve ser carregado `'B:\CONTAS.txt'`, porém os detalhes estão no **WITH**.

### WITH
#### FIRSTROW
Aqui definimos qual é a linha que deve começar a ser carragado os dados, no caso como a primeira linha desse [arquivo](CONTAS.txt), como a primeira linha é cabeçalho e não dados, se faz necessário carregar a partir da linha *2* como informado aqui: `FIRSTROW = 2`.

#### DATAFILETYPE
`DATAFILETYPE = 'CHAR'` Aqui é que tipo de dado será carregado no arquivo externo, como o arquivo de dados é um texto plano, logo o tipo de dados que será encontrado nesse arquivo será do tipo *CHAR*.

#### FIELDTERMINATOR
Aqui definimos o caracter separador de campos, no caso caso encontre o `\t` ou seja um *Tab*, o dado é preenchido em outro campo, no caso se tivermos um seprador **#** e no exemplo: `nome#01#codigo`, nesse exemplo, como o separador é *#* temos que o valor *nome* corresponde ao valor do primeiro campo, o *01* no segundo campo e o terceiro que no caso é o *codigo*, e assim respectivamente.

#### ROWTERMINATOR
`ROWTERMINATOR = '\n'` Aqui temos o separador de linha, no caso quando encontrar esse caracter, significa que o valor será uma nova linha na tabela, diferente do *FIELDTERMINATOR* que separa campos, esse separa linha, no caso o separador aqui é o `\n`, no caso o *Enter*

## Trigger
[Arquivo Exemplo 1](Trigger.sql)

[Arquivo Exemplo 2](Trigger2.sql)
### Criando Trigger
    --Trigger insercao
    create trigger trg_originais_backup_insert
    on dbo.dados_originais
    FOR INSERT
    AS
        DECLARE @id smallint
        DECLARE @valor varchar(30)
        DECLARE @data datetime

        SELECT @id = id from inserted
        SELECT @valor = valor from inserted	
        SET @data = getdate()

        print 'Trigger de insercao executada!'
        insert into dados_backup (fk,valor_novo,valor_antigo,criado) values (@id,@valor,@valor,@data)
    GO

#### create trigger trg_originais_backup_insert on dbo.dados_originais
Para criar uma Trigger, você deve inicialmente começar com `create trigger trg_originais_backup_insert on dbo.`**Nome Da Sua Tabela**. No caso o `dbo` se refere ao schema, no caso o Schema deve ser informado na criação de uma trigger e caso não exista um schema no seu banco de dados você deve usar o `dbo` que é ou padrão, ou usar o Schema aonde se localiza a sua tabela. No SQL Server o Schema é uma divisão lógica uma trigger deve ter o comando de criação `create trigger` seguido do nome da trigger `trg_originais_backup_insert` e o seu local, no caso o namespace e o nome da tabela `on dbo.dados_originais`

#### FOR AS AND GO
Essa parte da trigger deve ser informado qual evento deve ser monitorado, no caso do exemplo acima [criando trigger](readme.md#criando-trigger), o evento que estpa sendo monitorado é o **INSERT** e o `AS` e o `GO` formam um bloco aonde deve conter toda a lógica da trigger.

#### DECLARE
Aqui você declara as variáveis, no caso você usa a palavra reservada `DECLARE` após um espaço você deve informar o nome da variável, colocando um **@** na frente dele e seguido do seu tipo, como nesse exemplo `DECLARE @id smallint`, ou seja: `DECLARE @VARIAVEL TYPE`.

#### SELECT SET
Ambos definem valores a variáveis criadas pelo `DECLARE`, no caso o `SELECT` recomenda-se uso quando o dado se originar de alguma tabela e o `SET` quando se originar de função, isso seria uma convenção no caso, repare aqui `id from inserted` o `from inserted` referencia uma tabela temporária do SQL Server, no caso quando você exclui dados ou atualiza, o dado é movido e fica lá por um tempo na tabela `deleted`, caso você precisa acessar o dado antigo, que estava na tabela antes de ser excuído ou alterado, a tabela a ser analizada é essa, já a `inserted`é aonde fica o novo dado, ou seja o dado a ser incluído, semelhante a Trigger no mysql nesse caso em específico. Na exclusão você tem a tabela temporária `deleted`, na inserção `inserted` e na atualização ambas as tabelas. Além disso você atribuir dados de funções também `SET @data = getdate()`, por convenção nesse caso recomenda-se o uso do `SET` ao invés do `SELECT` para deixar tudo mais organizado, de modo a saber qual dado vem de função ou de tabela.

#### PRINT
Aqui `print 'Trigger de insercao executada!'` executa uma impressão no console quando essa trigger é executada.

#### Query na Trigger
Uma vez que os dados estejam declarados e com os seus respectivos valores, você pode usar eles em uma query de inserção em outra tabela por exemplo: `insert into dados_backup (fk,valor_novo,valor_antigo,criado) values (@id,@valor,@valor,@data)`, nesse caso estamos simulando uma rotina de backup.

### Excluíndo uma Trigger
`drop trigger trg_originais_backup_insert `, o comando é simples, use o `drop trigger` **NOME_DA_TABELA**, ou seja as duas palavras reservadas `drop trigger`, espaço e o nome da sua tabela.

### Atualização
    create trigger trg_originais_backup_update
    on dbo.dados_originais
    FOR UPDATE AS
    IF UPDATE(valor)
    BEGIN
        DECLARE @id smallint
        DECLARE @novo_valor varchar(30)
        DECLARE @antigo_valor varchar(30)			

        SELECT @id = id from inserted
        SELECT @novo_valor = valor from inserted
        SELECT @antigo_valor = valor from deleted
        

        update dados_backup set valor_antigo = @antigo_valor where fk = @id
        update dados_backup set valor_novo = @novo_valor where fk = @id
        update dados_backup set ultima_mudanca = getdate() where fk = @id
        print 'Trigger de atualizacao executada!'
    END
    GO

#### IF UPDATE
Esse `IF UPDATE` não é obrigatório em uma trigger de atualização, porém ele é necessário caso você queira monitorar apenas uma coluna, sem essa expressão, toda a tabela é monitorada, com essa expressão logo após o `FOR UPDATE AS`, você consegue monitorar um campo em específico, de modo que você poderia criar triggers exclusivas para campos de uma tabela. O campo que está sendo monitorado é o campo **valor**, o que explica o `IF UPDATE(valor)`. Esse comando é parte do **TSQL**, logo se faz necessário colocar ele dentro de um bloco `BEGIN` e `END`, sempre que for usar o **IF** a condição deve estar envolta desse bloco.

### Na exclusão
    -- Trigger para deletar
    create trigger trg_originais_backup_delete
    on dbo.dados_originais
    FOR DELETE
    AS
        DECLARE @id smallint	
        SELECT @id = id from deleted		

        update dados_backup set fk = null where fk = @id
        delete from dados_backup where id = @id
        print 'Trigger de exclusao executada!'
    GO

#### Explicando
A única diferença é o `DELETE`, além disso repare que está sendo executado mais de uma query, no caso: `update dados_backup set fk = null where fk = @id` e `delete from dados_backup where id = @id`.

### RAISERROR e ROLLBACK TRANSACTION
    CREATE TRIGGER TRG_FUNCSAL
    ON FUNCSAL_LIMITE
    FOR INSERT,DELETE
    AS
        BEGIN
            RAISERROR('OPERACAO NAO PERMITIDA PARA FUNCSAL_LIMITE',16,1)
            ROLLBACK TRANSACTION
        END
    GO
#### Explicando
`RAISERROR` esse seria equivalente ao *throw new* das linguagens de programação, no caso você pode criar erros customizáveis. O **16** é a naturaza do erro, todo o tipo de erro que tem o nível **16** e o estágio **1** é nível referente ao usuário, logo esse é o motivo de usar esses códigos. Essa é a forma como se executa um **rollback** no SQL Server: `ROLLBACK TRANSACTION`. 

### Outra sintaxe
    CREATE TRIGGER TRG_LIMITE_FUNCSAL
    ON DBO.FUNCSAL
    FOR INSERT, UPDATE
    AS
        DECLARE 
            @ID SMALLINT,
            @SALARIO MONEY,
            @PISO MONEY,
            @TETO MONEY

        SELECT @ID = ID, @SALARIO = SALARIO FROM DBO.FUNCSAL
        SELECT @PISO = PISO, @TETO = TETO FROM DBO.FUNCSAL_LIMITE

        IF(@SALARIO > @TETO)
            BEGIN
                RAISERROR('VALOR ACIMA DO TETO',16,1)
                ROLLBACK TRANSACTION
            END
        ELSE IF(@SALARIO < @PISO)
            BEGIN
                RAISERROR('VALOR ABAIXO DO PISO',16,1)
                ROLLBACK TRANSACTION
            END
        ELSE
            BEGIN
                PRINT('QUERY EXECUTADO COM SUCESSO!')
            END
    GO
#### Desvio Condicional
Aqui temos um exemplo de desvio condicional, no caso isso funciona exatamente como nas linguagens procedurais, como o pascal por exemplo, aonde você tem o **IF-ELSE-ELSEIF**, que avalia uma expressão booleana, porém lembre-se de colocar as condições dentro de um bloco **BEGIN** e **END**, o que não difere em nada com relação ao pascal por exemplo.

#### SELECT DECLARE
Você pode usar em **DECLARE** como bloco igual no código acima, no caso usar isso para declarar várias variáveis de uma vez, mas lembre-se de separar cada variável com vírgulas **,**, além disso você pode usar no comando **SELECT** a definição de mais de uma váriável como nesse exemplo: `SELECT @ID = ID, @SALARIO = SALARIO FROM DBO.FUNCSAL`, no caso: `SELECT`**@variável = coluna** `SELECT FROM SCHEMA.TABELA`.

### Monitorando dois Eventos
    CREATE TRIGGER TRG_FUNCSAL_LIMITE_ORDEM
    ON DBO.FUNCSAL_LIMITE
    FOR INSERT,UPDATE
    AS
        DECLARE @PISO MONEY
        DECLARE @TETO MONEY
        SELECT @PISO = PISO, @TETO = TETO FROM DBO.FUNCSAL_LIMITE
        IF(@PISO >= @TETO)
            BEGIN
                RAISERROR('PISO ACIMA DO TETO',16,1)
                ROLLBACK TRANSACTION
            END
        ELSE
            BEGIN
                PRINT('QUERY EXECUTADO COM SUCESSO!')
            END
    GO

### Explicando
Você pode monitorar mais de um evento se preferir, no caso estamos monitorando a inserção e a atualização, definido aqui `FOR INSERT,UPDATE`, lembre-se de usar a virgula como um separador.

## Criando Procedures
[Arquivo básico de Procedure](Procedure1.sql)

[Arquivo Procedure retorno](Procedure2.sql)
### Exemplo básico
    CREATE PROC SELECTIONAR_TUDO
    AS
        SELECT D.ID, D.NOME,E.RUA,E.CIDADE,E.ESTADO	 
        FROM FUNCIONARIO_DADO D INNER JOIN FUNCIONARIO_END E
        ON D.ID = E.FK 
    GO
    
    EXEC SELECTIONAR_TUDO
    GO

### CREATE PROC
Para criar uma procedure você pode usar `CREATE PROC`**NOME-DA-TABELA** ou `CREATE PROCEDURE`**NOME-DA-TABELA**. além disso você deve colocar a query dentro de um bloco `AS` e `GO`. Para executar esse procedimento recomenda-se usar o `EXEC`, você pode chamar um procedimento sem isso, mas recomenda-se usar.

### Exemplo com Entrada de Parâmetro
    CREATE PROCEDURE SELECIONAR_ID @ID SMALLINT
    AS
        SELECT D.ID, D.NOME,E.RUA,E.CIDADE,E.ESTADO	 
        FROM FUNCIONARIO_DADO D INNER JOIN FUNCIONARIO_END E
        ON D.ID = E.FK
        WHERE D.ID = @ID 
    GO

### Parâmetros
Inicialmente você define na procedure o parametro, nesse caso temos o `@ID SMALLINT`, o `@` indica que é uma variável e o `SMALLINT` é o tipo de dados, você deve informar o tipo de assim que você declara a variável. Para chamar

#### Chamando:
    EXEC SELECIONAR_ID 1
    GO

O um é o parametro exigido, no caso estamos passando como parametro o número 1.

### Exemplo com mais parâmetros
    CREATE PROC INSERIR @NOME VARCHAR(50), @RUA VARCHAR(50), @CIDADE VARCHAR(20), @ESTADO CHAR(2)
    AS
        INSERT INTO FUNCIONARIO_DADO (NOME) VALUES (@NOME)        
        INSERT INTO FUNCIONARIO_END(FK,RUA,CIDADE,ESTADO) VALUES (@@IDENTITY,@RUA,@CIDADE,@ESTADO)
    GO

#### Chamando:
    EXEC INSERIR 'JOAO','RUA DAS FLORES','RIO DE JANEIRO','RJ'
    INSERIR 'MARIA','RUA DAS MARGARIDAS','SAO PAULO','SP'

#### @@IDENTITY
Essa variável retorna o ultimo valor criado por identity, por exemplo como nessa linha o ID é criado automaticamente `INSERT INTO FUNCIONARIO_DADO (NOME) VALUES (@NOME) `, pois é um campo identity, o valor de `@@identity` é tem como valor, o ultimo valor gerado por aquela tabela, se outra tabela gerar o *identity*, esse valor será o identity de outra tabela, sendo o valor o ultimo valor criado. No caso estamos usando isso aqui `INSERT INTO FUNCIONARIO_END(FK,RUA,CIDADE,ESTADO) VALUES (@@IDENTITY,@RUA,@CIDADE,@ESTADO)`, como o identity foi usado pela ultima vez na tabela **FUNCIONARIO_DADO** no ato de inserir, logo esse valor se refere a essa tabela e ao ultimo lugar criado.

#### EXEC
Sempre use o `exec`, ele não é essencial para o funcionamento, mas importante para a legibilidade de toda a query, para que possa ficar claro de que se trata de uma procedure.

### Procedimento que retorna valores
    CREATE PROC RETORNA_NOME @ID SMALLINT, @NOME VARCHAR(50) OUTPUT
    AS
        SELECT @NOME = NOME FROM DBO.FUNCIONARIO_DADO
        WHERE ID = @ID
    GO

#### OUTPUT
Pode-se retornar valores através do `OUTPUT`, você deve informar o valor que pode ser exportado, como nesse exemplo: `@NOME VARCHAR(50) OUTPUT`, mas lembre-se que você precisa informar valores a variável a ser exportado, do contrário retornado nulo. No caso esse processo ocorre aqui: `@NOME = NOME`, nesse trecho estamos passando valor a váriável `@NOME`ao qual ficará visível externamente.

### Passando valor para variáveis.    
    DECLARE @SAIDA varchar(50)    
    EXEC RETORNA_NOME 2, @NOME = @SAIDA OUTPUT    
    SELECT @SAIDA as "OUTPUT"
    GO

#### Explicando
Inicialmente você precisa declarar a variável `DECLARE @SAIDA varchar(50)`, lembrando que o tipo da variável precisa do mesmo tipo que o retorno, aqui é executado o procedimento e atribuido valor a variável `EXEC RETORNA_NOME 2, @NOME = @SAIDA OUTPUT`, repare nessa parte `@NOME = @SAIDA OUTPUT`. Aqui nós estamos passando o valor de `@NOME` a variável de `OUTPUT` na variada criada `@SAIDA`, ou seja: **@VARIAVEL_EXPORTADA = @VARIAVEL_QUE_VAI RECEBER OUTPUT**, além disso o `OUTPUT` é obrigatório do contrário o valor não será passado a essa variável.

### Variavel Global
    DECLARE @@VISIVEL VARCHAR(50)
    EXEC RETORNA_NOME 3, @NOME = @@VISIVEL OUTPUT
    SELECT @@VISIVEL AS "VALOR GLOBAL"
    GO

##### @@
Quando tem um arroba a variavél tem escopo local, quando possuí dois o escopo da variável é ampliado.

### Excluíndo
    DROP PROC RETORNA_NOME
    GO

Você excluir um procedimento dessa forma, lembrando que você pode usar `PROC` ou `PROCEDURE`.