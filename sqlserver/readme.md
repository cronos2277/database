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
