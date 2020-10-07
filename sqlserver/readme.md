# SQL Server

## Clausura GO
O SQL Server por padrão funciona de maneira assincrona, além disso ele executa o bloco mais rápido primeiro, se voce enviar um comando para criar um banco de dados e outro para usar o banco de dados, será executado sempre o comando de usar, antes mesmo do comando de criar, mesmo que o comando de criação venha antes, isso ocorre porque o SQL server executa sempre o comando mais rápido primeiro, no caso com a clausura GO, você faz o banco de dados se comportar da maneira tradicional, executando o comando na ordem que você digitou. Ou seja com o GO todos aqueles comando viram um bloco e ele executa todo aquele bloco até o GO como qualquer outro banco de dados, porém na sua ausencia ele executa os comandos de maneira assincrona e priorizando os comandos mais rápidos primeiro.

## Arquivos
[Arquivo Basico e comparando com o MySql](SQLServer_Query.sql)

## Tipo de dados
### Identity
Esse marcador é equivalente ao *auto_increment* do mysql, porem ele aceita parametros, se não hou ver parametros, como por exemplo `id int primary key identity`, nesse caso ele funciona de maneira equivalente ao auto_increment e aumenta em um em um partindo do valor 1. Nesse exemplo `id int primary key identity(1,1)`, nesse caso inicia-se do um e incrementa um, no caso com o identity, é possível definir o número de início e a forma de incremento.

## Funções
`select getdate()` => Pega a hora atual, o ano ao segundo.

## Procedimentos
`SP_Help [tabela]` => Mostra todas  as informações de `[tabela]`.

`SP_Columns [tabela]` => Mostra as informações detalhadas de todas as colunas de `[tabela]`.

