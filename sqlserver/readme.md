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

