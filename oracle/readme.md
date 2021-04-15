# Oracle
01.[SQL Plus](#sql-plus)

02.[Datas no Oracle](#datas-no-oracle)

03.[Funções úteis](#funções)

04.[Sequência](#sequência)

05.[Dicionário de dados no Oracle](#dicionário-de-dados)

06.[Index](#index)

07.[Views](#views)

08.[Synonym](#synonym)

09.[PL/SQL](PLSQL/readme.md)

10.[Tabela Temporária](#tabela-temporaria)

11.[Oracle Forms](Forms)

12.[Oracle Reports](Report)

## SQL Plus
### Comandos
Esses comandos funciona apenas no *SQLPLUS*, ou seja essas aplicações podem funcionar ou não em uma ferramenta, mas no SQL Plus funciona, além disso se faz necessário executar o comando `COMMIT` para que as alterações sejam salvas, salvo se o autocommit estiver habilitado, algo que **NÃO** é padrão no **Oracle DB**.

#### ED
Ao digitar `ed` no terminal com o *sqlplus* será exibido todos os comandos digitados no buffer, no caso se abre uma janela no bloco de notas e ali exibe todos os comandos que estão no buffer. Dessa forma você pode editar todos os comandos digitados anteriormente, por exemplo se você digitou `select * dual`, você pode arrumar esse comando com o comando `ed` e alterar esse comando para `select * from dual` e dessa forma ter no buffer um comando que possa de fator ser executado, usando as teclas cima e baixo quando tiver navegando pelos históricos de comando slavos no buffer. Uma vez feito isso você seleciona o comando do buffer e usa o comando `/` para que possa ser impresso o que foi retornado pelo comando `ed`. Ou seja, use o comando `ed`, faça as edições, salve e fecha o bloco de notas e uma vez que o cursor voltar a piscar no *sqlplus* digite `/` e após isso pressione **ENTER**, dessa forma você executa o conteúdo editado no buffer.

    ed
    [Faça as alterações no notepad, salve e feche o arquivo]
    /
    [ENTER]


#### SHOW ERROR
No *SQLPLUS* você pode ter acesso aos detalhes de todos os erros das query através desse comando, no caso é exibido uma tabela com o código do erro e uma breve descrição dele, muito útil na programação de blocos *PL/SQL*.
#### LIST
Ao digitar `list` você pode ver tudo que está salvo no buffer do *sqlplus*.

#### L'numero da linha'
Você pode ter acesso ao conteúdo de uma linha em específico salvo do buffer, por exemplo, para pegar a primeira linha salva no buffer `l1`, assim como a segunda `l2`, terceira `l3` e por ai vai, o comando `l` é um atalho para `list` ou seja `list 1` funcionaria da mesma forma.

    l[numero da linha]
    /
    [ENTER]

#### RUN
Executa o ultimo comando salvo no buffer, apenas pressione enter após ser digitado `run`.

#### APPEND
Esse comando permite concatenar qualquer o dado digitado conteúdo que está no buffer, por exemplo se você selecionar a primeira linha com `l1` e que contem a instrução `select * from dual` e digita
`append where id = 3` ou `a where id=3` você tem o seguinte comando `select * from dualwhere id=3`, para evitar esse tipo de coisa, usa-se duas barras de espaço após o *append*, dessa forma você tem `select * from dual where id=3` ao invés de `select * from dualwhere id=3`. O comando para concatenar instruções com a linha selecionada pode ser tanto `append` *e um espaço* assim como `a` *e um espaço*, o que vier após esse espaço será concatenado a instrução selecionada.

    [selecione a linha a concatenar ex: [l1],[l2]]
    append [ESPAÇO][QUERY COMPLEMENTAR]
    /
    [ENTER]

#### INPUT
Esse comando permite concatenar ao dado digitado no buffer uma quebra linha seguido das instruções que serão adicionadas. Por exemplo essa instrução `select * from dual` após digitado `input where id = 3` ou `i where id=3`, o resultado fica:

    select * from dual
    where id=3

Ou seja é feito uma quebra de linha, o input segue a mesma lógica que o *append*, mas diferente do *append* o *input* adiciona uma quebra de linha.

#### Salvando e carregando Queries
Para isso você selecione o comando, seja pelo `ed` ou seja por `l` e após isso use a palavra reservada `save` seguido do nome que a query deve ter. Por exemplo se você criar uma query que se chama **comando**, você basicamente selecione a query que você quer salvar e após feito isso, você usa o comando `save comando`, se tudo ocorrer bem o *sqlplus* deve ter o seguinte output *Criado file comando.sql* informando que tudo ocorreu bem, lembrando que o comando é o nome dado ao arquivo e não faz parte da estrutura do comando. Para acessar uma query salva você usa o comando `get`, que nesse exemplo fica `get comando`, após isso de um enter e então execute o comando `/` seguindo de **ENTER** para que a query salva seja executada. Resumindo:

    get comando
    [ENTER]
    /
    [ENTER]

### Setando valores
Você verificar todas as configurações setadas usando o seguinte comando `SHOW ALL`, inclusive se o autocommit está setado ou qual é o valor do *sql prompt*.

#### SET SQLPROMPT "[VALOR]"
Esse `[VALOR]` deve ser informado os valores, as aspas é importante pois o Oracle pode ter problemas ao processar Strings sem elas. Nesse caso, no prompt ao invés de exibir `SQL>` será exibido o valor informado dentro das aspas.

#### SET AUTOCOMMIT [ON|OFF]
O comando `SET AUTOCOMMIT ON` habilita o commit automático, algo perigoso para habilitar em ambientes de produção, assim como `SET AUTOCOMMIT OFF` desabilita, caso o *autocommit* esteja desabilitado, os dados só são comitados quando o comando `commit` for executado, que deve retornar o seguinte output *Commit concluído*.

### Variáveis
Você pode usar o `&` para definir uma variável, ao qual será questionado pelo Oracle, caso a variável não esteja previamente definido pelo *define*, por exemplo `select * from &tabela where id = &id`. Nesse exemplo caso não esteja definida um valor para a variável `&tabela` ou `&id` o oracle deve perguntar qual deve ser o valor delas e esses valores serão interpolados a query, por exemplo se o valor de `&tabela` for `REGISTRO` e `&id` tiver o valor de `2`, e com a interpolação feita, a seguinte query é executada `select * from REGISTRO where id = 2`. Porém para valores em string ou datas recomenda-se o uso de aspas, por exemplo se `&tabela` recebe um valor string deve ficar `select * from "&tabela" where id = &id`, ou seja com a variável dentro das áspas, uma vez que strings aceitam caracteres, que quando interpolados podem comprometer a execução da query.

#### Definindo variáveis
Para você definir uma variável você deve usar a seguinte sintaxe `define [variável] = [valor]`, caso a variável esteja definida, a mesma já terá o seu valor, por exemplo se você fizer essa definição `define id = 2` e `define tabela = 'REGISTRO'`, quando for executado essa query `select * from "&tabela" where id = &id`, o valor de table sempre será interpolado para `REGISTRO` e id para `2`.

## Datas no Oracle
Você pode obter o dia mês e ano atual usando a seguinte query `select sysdate from dual` detalhe, todo comando de projeção de usando o `select` deve se referenciar a alguma tabela, no caso a *oracle* criou uma tabela para que essa referencia seja feita, sem que você precise informar uma tabela que você criou e dessa forma tornar tudo mais confuso, o output dessa query seria algo como `dd/mm/yy`, ex: `26/01/21`.

### Mascaras
Você pode usar o `to_char` para formatar uma data, o primeiro argumento da função é a data e o segundo a máscara, podendo usar o **sysdate** para pegar a data atual, ou informar uma data, nesse caso você poderia usar a função com dois parâmetros, com base na data `26/10/2021`:

`select to_char(sysdate,'dd/mm/yy') from dual;` *=>* **26/01/21**

`select to_char(sysdate,'d') from dual;` *=>* **3** *=>* **(1 => Domingo, 2 => Segunda, 3 => Terça, 4 => Quarta, 5 => Quinta, 6 => Sexta, 7 => Sábado).**

`select to_char(sysdate,'day') from dual;` *=>* **terça-feira** => **(1 => Domingo, 2 => Segunda-feira, 3 => Terça-feira, 4 => Quarta-feira, 5 => Quinta-feira, 6 => Sexta-feira, 7 => Sábado).**

`select to_char(sysdate,'mm') from dual;` *=>* **1** *=>* **(1 => Janeiro, 2 => fevereiro ... 11 => Novembro, 12 => dezembro).**

`select to_char(sysdate,'mon') from dual;` *=>* **jan** **(1 => jan, 2 => fev ... 11 => nov, 12 => dec).**

`select to_char(sysdate,'MON') from dual;` *=>* **JAN** **(1 => JAN, 2 => FEV ... 11 => NOV, 12 => DEC).**

`select to_char(sysdate,'Mon') from dual;` *=>* **Jan** **(1 => Jan, 2 => Fev ... 11 => Nov, 12 => Dec).**

`select to_char(sysdate,'month') from dual;` *=>* **janeiro** **(1 => janeiro, 2 => fevereiro ... 11 => novembro, 12 => dezembro).**

`select to_char(sysdate,'MONTH') from dual;` *=>* **JANEIRO** **(1 => JANEIRO, 2 => FEVEREIRO ... 11 => NOVEMBRO, 12 => MARÇO).**

**Como você pode perceber, se o segundo parametro for passado, capitalizado o resultado é capitalizado, minusculo retorna minusculo e maiúsculo retorna em mauísculo.**

`select to_char(sysdate,'yy') from dual;` *=>* **21.**

`select to_char(sysdate,'yyyy') from dual;` *=>* **2021.**

`select to_char(sysdate,'year') from dual;` *=>*  **twenty twenty-one.**

**Obs: São 10 horas da noite agora**

`select to_char(sysdate,'hh') from dual;` *=>* **10** no caso retorna a hora em formato de 12.

`select to_char(sysdate,'hh24') from dual;` *=>* **22** no caso retorna a hora em formato de 24.

`select to_char(sysdate,'mi') from dual;` *=>* **57** Retorna os minutos.

`select to_char(sysdate,'ss') from dual;` *=> **59** Retorna os segundos.

### Operações com datas
Você pode somar ou subtrair datas, como nesse exemplo `select to_date('22/12/1990') + 1 from dual;`, nesse caso teríamos `23/12/1990`, no caso se faz necessário dar um cast usando `to_date` para dai então seguir com a operação matemática. Porém se for usar o *sysdate* você não precisa dar um cast usando *to_date*, nesse exemplo `select sysdate - 5 from dual;`, sendo a data de hoje `26/01/21` seria `21/01/21`.

### Montando uma query complexa

    select 'Brasil, ' || to_char(sysdate,'dd')
    || ' de ' || to_char(sysdate,'Month') 
    || ' de ' || to_char(sysdate,'YYYY')
    || ' as ' || to_char(sysdate, 'hh24:mi:ss')
    from dual;

###### output
    Brasil, 26 de Janeiro   de 2021 as 22:52:59

O mês tem um espaço fixo no oracle, logo tem essa sobra de espaço em branco mesmo e os duplos pipes `||` fazem concatenação de *string*.

### Adicionando meses a data
Valor positivo projeta a data para o futuro, negativo para o passado, por exemplo `select to_char(add_months(sysdate,2),'dd/mm/yyyy') from dual;` geraria o output `26/03/2021`, no caso o primeiro argumento é a data e o segundo quantos meses devem ser adicionados, lembrando que número negativo reduz. Essa é a forma correta, uma vez que essa função considera os meses que tem 30 e 31 dias e inclusive que fevereiro tem 28 ou 29 dias, nesse caso `26/01/21` virou `26/03/21`, o que poderia ter um resultado diferente se fosse somar 60 dias, uma vez que fevereiro tem apenas 28 dias em 2021.

### Pegando ultimo dias do mês
`select last_day(sysdate) from dual;` *=>* `31/01/21`, como é janeiro é 31, mas se fosse feveiro poderia ser 28 ou 29 (se o ano for bissexto), de todo modo a função te retorna o ultimo dia do mês de maneira automática, uma vez que os meses podem variar de 28 a 31 dias.

### Calculo de meses entre datas
Por exemplo essa query `select months_between('01/01/21', '31/12/21') from dual;` resultaria em: `11,96774193548387096774193548387096774194`, que representa a distancia entre os meses.

## Funções

### Concatenação
`select concat('abc','def') from dual;` *=>* `abcdef`, essa função concatena duas strings, porém se precisar fazer concatenação com mais de 2 string pode se usar dois pipes `||`, exemplo `select 'abc' || 'def' || 'ghi' from dual` *=>* `abcdefghi`. Porém se for para concatenar valores que não seja string, ou valores que o double pipe pode dar problemas, existe o *concat*.
### abs
`select abs(-9.9) from dual;` *=>* `9.9`, a função abs tira o sinal de um valor numérico, assim como funciona nas linguagens de programação.

### ceil
`select ceil(9.1) from dual;` *=>* `'10`, a função redonda o valor para o maior inteiro mais próximo.

### floor
`select floor(9.9) from dual;` *=>* `9`, a função redonda o valor para o menor inteiro mais próximo, ao contrário do *ceil*.

### power
`select power(4,2) from dual;` *=>* `16`, essa função é equivalente a *pow* das linguagem de programação, sendo o primeiro argumento a base e o segundo o expoente.

### sqrt
`select sqrt(16) from dual;` *=>* `4`, essa função extraí a raíz quadrada do número informado.

### mod
`select mod(3,2) from dual;` *=>* `1`, essa função divide o primeiro argumento pelo segundo e retorna o resto da divisão.

### round e trunc
Quando zero a parte decimal é cortada, positivo a parte decimal do número é movido a direita, quando negativo é movido a esquerda.
#### segundo argumento igual a zero
`select round(123.456,0) from dual` *=>* `123`, nesse caso o round faz um arredondamento floor quando o valor decimal é menor que `5` e ceil em outras situações. *Obs:O valor zero é o padrão.*

#### segundo argumento maior que zero
`select round(123.456,1) from dual;` *=>* `123.5`, no caso é feito o arredondamento mantendo as casas decimais caso caso o segundo argumento seja maior que zero, no caso o arredondamento é feito mantendo o número de casas decimais informado no segundo argumento, nesse exemplo uma casa decimal, e como o segundo número após a vírgula é maior ou igual a 5, logo o arrendondamento é feito usando o *ceil*.

#### terceiro argumento menor que zero
`select round(123.456,-1) from dual;` *=>* `120`, `select round(123.456,-2) from dual;` *=>* `100`, `select round(123.456,-3) from dual;` *=>* `0`. Nesse caso é feito a aproximação com base 10, por exemplo quando está *-1* como segundo argumento é feito o arrendondamento no número divisível por *10* mais próximo, no caso do *123* o número divisível por *10* mais próximo é o *120*, ao passo que se fosse *127* por exemplo seria *130* o output, ou seja ao invés de fazer o arredondamento com base no inteiro ao ter *-1* faz com base na dezena e quanto mais for decrementado um número negativo maior é a base 10 para a comparação, por exemplo: *-1* => *inteiro próximo de (numero/10)*, *-2* => *inteiro próximo de (numero/100)*, *-3* => *inteiro próximo de (numero/1000)* e por ai vai.

#### Trunc
Essa função tem a mesma lógica que o *round*, mas ao invés de fazer um redondamento *floor* ou *ceil*.
##### trunc (segundo argumento menor que 0)
`select trunc(123.456,-1) from dual;` => *120* **<-- move a virgula a esquerda e devolve a penas a parte inteira sem arredondar.**

##### trunc igual a zero ou com o segundo argumento omitido
`select trunc(123.456) from dual;` => *123* **<-- Mantém apenas a parte inteira.**
##### trunc (segundo argumento maior que 0)
`select trunc(123.456,1) from dual;` => *123,4 **<-- move a virgula a direita e mantém o número de casas decimais, informado.**

### Função ASCII
`select ascii('a') from dual;` *=>* **97**, retorna o código **ascii** de determinado caracter informado.

### Função CHR
`select chr(97) from dual;` *=>* **a**, retorna o caracter correspondente a esse número da tabela **ascii**. Funciona de maneira inversa a `ascii('char')`.

### UPPER
`select upper('abcdef') from dual;` *=>* **ABCDEF**, essa função colocar todas as letras para maíusculas.

### LOWER
`select lower ('ABCDEF') from dual;` *=>* **abcdef**, essa função transforma tudo em minúsculo.

### INITCAP
`select initcap('abcdef') from dual;` *=>* **Abcdef**, essa função capitaliza a primeira letra de cada palavra.

### LPAD
`select lpad('texto', 10, '#') from dual;` *=>* **#####texto**, essa função coloca a **esquerda** da string informada no primeiro parametro, os caracteres informados no terceiro, sendo essa quantidade de caracteres a esquerda da string informada no primeiro parametro informado no segundo parametro.

### RPAD
`select rpad('texto', 10, '#') from dual;` *=>* **texto#####**, essa função coloca a **direita** da string informada no primeiro parametro, os caracteres informados no terceiro, sendo essa quantidade de caracteres a esquerda da string informada no primeiro parametro informado no segundo parametro.

### LENGTH
`select length('abcde') from dual;` *=>* **5**, essa função retorna a quantidade de caracteres dentro da string, o que incluí `\n \s \t`, etc...

### Replace
`select replace('texto','t','f') from dual;` *=>* **fexfo**, essa função substituí a string informada no primeiro argumento, substituindo dela os caracteres informados no segundo argumento, pelos caracteres informados no terceiro argumento, caso haja as ocorrências, conforme demonstrado.

### SUBSTR
`select substr('texto',2,3) from dual;` *=>* **ext**, pega da string informado no primeiro argumento, começando na posição informado no segundo, pega a quantidade de caracteres informado pelo terceiro argumento.

## Sequência
No oracle as sequências é um objeto a parte que pode ser acoplado a uma tabela, por se tratar de um objeto externo, você pode usar a mesma sequencia para mais de uma tabela inclusive.
### Criando sequência
`create sequence [nome];` essa é maneira mais simples de se criar uma sequência, no caso tudo é criado de maneira padrão, dessa forma o valor inicial é `1`, o valor final é `9999999999999999999999999999`, o incremento é feito de um em um, são carregados na memória 20 sequencias por vez. Tudo isso é setado quando você usa os valores padrões. [Documentação](https://docs.oracle.com/cd/B12037_01/server.101/b10759/statements_6014.htm) *Obs: substitua os colchetes pelo nome da sequência que você quer dar.*

#### Criando sequência com parâmetros
    ex: `sequence [NOME DA SEQUENCIA] start with 1 increment by 1 minvalue 1 maxvalue 9999 cache 40 cycle order;`

`start with [NUMERO]` => Define o número pelo qual a sequência deve iniciar.

`increment by [NUMERO]` => Define a forma de incremento.

`minvalue [NUMERO]` => Define o menor valor para a sequência.

`maxvalue [NUMERO]` => Define o valor máximo para a sequência.

#### Flags Cache, cycle e order

##### CACHE
>Especifique quantos valores da sequência o banco de dados pré-aloca e mantém na memória para acesso mais rápido.Este valor inteiro pode ter 28 ou menos dígitos.O valor mínimo para este parâmetro é 2. Para sequências desse ciclo, este valor deve ser menor que o número de valores no ciclo.Você não pode armazenar em cache mais valores do que cabem em um determinado ciclo de números de sequência.Portanto, o valor máximo permitido para CACHE deve ser menor que o valor determinado pela seguinte fórmula: `(CEIL (MAXVALUE - MINVALUE)) / ABS (INCREMENT)` Se ocorrer uma falha do sistema, todos os valores de sequência em cache que não foram usadosem declarações DML confirmadas são perdidas.O número potencial de valores perdidos é igual ao valor do parâmetro CACHE.
##### ORDER
>Especifique ORDER para garantir que os números de sequência sejam gerados na ordem da solicitação.Esta cláusula é útil se você estiver usando os números de sequência como carimbos de data / hora.Garantir a ordem geralmente não é importante para sequências usadas para gerar chaves primárias.ORDER é necessário apenas para garantir a geração ordenada se você estiver usando o Oracle Database com Real Application Clusters.Se você estiver usando o modo exclusivo, os números de sequência são sempre gerados em ordem.

##### CYCLE
>Especifique CYCLE para indicar que a sequência continua a gerar valores após atingir seu valor máximo ou mínimo.Depois que uma sequência ascendente atinge seu valor máximo, ela gera seu valor mínimo.Depois que uma sequência descendente atinge seu mínimo, ela gera seu valor máximo.



### CURRVAL
Inicalmente você usar o `CURRVAL` para saber qual é o valor corrent da sua sequência, como nesse exemplo `select [nome_da_sequencia].currval from dual;`, porém é importante salientar que caso a sequência não tenha sido usada anteriormente, dará erro na execução, pois o valor de `CURRVAL` só é criado após o primeiro uso, ou seja ao criar com o `create sequence` não fará com que o atributo `.currval` esteja disponível, mas para isso você deve usar-lo ao menos uma vez. *Obs: substitua os colchetes pelo nome da sequência.*

### NEXTVAL
Com esse atributo você faz o uso da sequência, no caso o valor é modificado e após isso o mesmo é interpolado, seria o equivalente ao `++variavel` ou `--variavel` das linguagens de programação, segue um exemplo de uso, *Obs: lembrando sempre em substituir os valores dos colchetes pelos seus correspondentes*:

    insert into [NOME DA TABELA] values([NOME DA SEQUENCIA].nextval,'valor de outro campo');

Veja que existe um baixo acoplemento entre a sequencia visto aqui `[NOME DA SEQUENCIA].nextval` e a tabela, o que permite usar a mesma sequência em várias tabelas, no caso com o `.nextval` é usado o valor, agora se você quiser usar esse mesmo valor gerado pela sequência em outras tabelas, você poderia usar o *currval* `insert into [NOME DA TABELA] values([NOME DA SEQUENCIA].currval,'valor de outro campo');`

### Apagando sequência
Para isso use `drop sequence [nome];`, importante salientar que excluir a sequência não afeta o funcionamento da tabela, uma vez que não há acoplamento e a sequência compõe parte do comando de inserção de dados e não a estrutura como ocorre em outro banco de dados.

### Modificando sequência
Para isso use `alter sequence [nome] [novas opções como cycle minvalue = 1, etc...];`, por exemplo `alter sequence bai_seq nocycle noorder;` o *nocycle* desabilita a tag *cycle* da tabela, assim como a *noorder* desabilita a tag *order*.

## Dicionário de Dados
Você pode ter acesso aos dados do usuário colocando colocando `user_` + o que você quer listar, lembre-se que sempre deve ser no plural, por exemplo, :

`select * from user_tables;` => Exibe todas as tabelas.

`select * from user_views;` => Exibe todas as views que o usuário criou.

`select * from user_indexes;` => Exibe todos os índices.

Ou seja se quiser que o **oracle** exiba uma lista de um objeto desses, basta ir a tabela `user_`**tipo no plural**.Se não houver determinado objeto na sua database pode ser que ocorra um erro.

## Index
`create index [nome] on [tabela]([campo]);`, usando essa sintaxe você cria um índice para esse campo, deve-se tomar cuidado para não exagerar na criação de index, uma vez que o index melhora a leitura mas a custa da escrita, ou seja o campo fica mais rápido de ler, porém mais lento na hora de inserir novos dados, uma vez que deve-se reindexar os dados a cada inserção. O `[nome]` deve ser substituído pelo nome que o index deve ter, o `[tabela]` pelo nome da tabela alvo do index, com o campo a ser indexado informado em `[campo]`. Para apagar use `drop index [nome];`, aonde `[nome]` deve ser substituído pelo nome do index criado. Alterar `alter index [nome] [opções]`, para mais informações, [segue a documentações](https://docs.oracle.com/cd/B19306_01/server.102/b14200/statements_1008.htm)

## Views
Para criar `create view [nome] as [select]`, aonde está `[nome]` você colocar o nome que você quer que a view tenha e aonde esta o `[select]` você deve colocar um select associado aquele *view*, no caso o *view* cria uma tabela virtual com base em um select, por exemplo: `create view bai_view as select * from bairro where bai_codigo > 2;` toda vez que for chamado `select * from bai_view` será chamado uma tabela virtual com a clausula where inclusa, ou seja nessa tabela virtual ficará todos os dados que atendam essa condição `bai_codigo > 2`, uma view tem por objetivo simplificar tabelas aos usuários assim como esconder determinados dados dos usuários, além disso o oracle permite a materialização de uma view o que faz com que se ganhe alguma performasse nesse select que está por trás dessa view, [Documentação](https://docs.oracle.com/cd/B19306_01/server.102/b14200/statements_8004.htm), para alterar `alter view [nome] [opções]`, [segue a documentação](https://docs.oracle.com/cd/B19306_01/server.102/b14200/statements_4004.htm#:~:text=When%20you%20issue%20an%20ALTER,those%20materialized%20views%20are%20invalidated.) e para excluir `drop view [nome]`, sendo esse `[nome]` o nome do view criado. Você pode também usar `create or replace [view] as select [select]`, com o **create or replace**, se existir a query é substituído e caso não exista, o mesmo é sobreescrito.

## Synonym
No Oracle também é possível criar um apelido a uma tabela com um nome muito longo, geralmente isso é util para simplificar o nome da tabela sem mexer nela assim como facilitar nas criações que query complexas visando reduzir o seu tamanho. Para isso `create synonym [apelido] for [tabela];`, aonde está o apelido, você coloca um nome da sua preferência, e o `[tabela]` é aonde você informa o nome da tabela. Por exemplo: `create synonym b for bairro;`, nesse caso você poderia fazer referência a essa tabela *bairro* usando o apelido, no caso `select * from b`, ou seja dessa forma foi possível criar um apelido para a tabela, você deve usar o **public** caso você queira que a tabela fique visível aos outros `create synonym public [apelido] for [tabela];`, com o comando **create or replace** `create or replace public synonym b for bairro;`, você pode subscreever caso já exista, além disso temos os `alter [public] synonym [apelido] for [tabela] [opções]`, [documentação](https://docs.oracle.com/database/121/SQLRF/statements_2016.htm#SQLRF56347), já para excluir `drop synonym [apelido];`, sendo que aonde está o `[apelido]` deve ser informado o valor correspondente.

## Tabela temporaria
Uma tabela temporária é excluída quando a sessão é encerrada, mantendo apenas a estrutura, ou seja os dados de uma tabela temporária não fica de maneira permanente registrada no banco, apenas a estrutura, o que pode ser útil quando se quer criar um `sandbox` para a manipulação de dados. Repare que uma tabela temporária é sempre global, uma vez que isso é nítido na sintaxe, uma vez que a mesma-o compõe.
### Primeira forma
    CREATE GLOBAL TEMPORARY TABLE [NOME] ([nome1] [tipo1], [nome2] [tipo2], etc...);

Através desse comando você cria uma tabela temporária, nesse caso a tabela é criada em branco e os dados adicionados a essa tabela serão excluídos após a desconexão.

### Segunda forma 

    CREATE GLOBAL TEMPORARY TABLE [TABELA] ON COMMIT PRESERVE ROWS AS [QUERY];

Nessa segunda forma você cria uma tabela com base em uma query, diferente de uma *view*, qualquer valor alterado na tabela original, não é refletido aqui, ou seja essa tabela passa a ser independente da outra e qualquer dado inserido nessa tabela, será perdido após o logout, ou seja é criado uma tabela temporária com base na **Query**, porém qualquer modificação na temporária não altera a original e qualquer alteração na original, não influência a temporária, e uma vez deslogado a tabela temporária tem seus dados excluídos.

`[TABELA]` => Aqui deve ser informado o nome da tabela.

`QUERY` => Aqui a query que será a base para a criação da tabela, deve-se ser uma query de projeção do tipo select.

### Terceira Forma

    CREATE GLOBAL TEMPORARY TABLE [TABELA] ON COMMIT DELETE ROWS AS [QUERY]

ou simplesmente

    CREATE GLOBAL TEMPORARY TABLE [TABELA] AS [QUERY];

Nessa forma é criada apenas a estrutura da tabela original, mas sem os dados, de toda forma qualquer dado inserido aqui, será excluído, mas diferente da segunda forma, essa cria apenas as estruturas sem os dados copiados.