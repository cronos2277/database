# Oracle
1.[SQL Plus](#sql-plus)

2.[Datas no Oracle](#datas-no-oracle)
## SQL Plus
### Comandos
Esses comandos funciona apenas no *SQLPLUS*, ou seja essas aplicações podem funcionar ou não em uma ferramenta, mas no SQL Plus funciona, além disso se faz necessário executar o comando `COMMIT` para que as alterações sejam salvas, salvo se o autocommit estiver habilitado, algo que **NÃO** é padrão no **Oracle DB**.

#### ED
Ao digitar `ed` no terminal com o *sqlplus* será exibido todos os comandos digitados no buffer, no caso se abre uma janela no bloco de notas e ali exibe todos os comandos que estão no buffer. Dessa forma você pode editar todos os comandos digitados anteriormente, por exemplo se você digitou `select * dual`, você pode arrumar esse comando com o comando `ed` e alterar esse comando para `select * from dual` e dessa forma ter no buffer um comando que possa de fator ser executado, usando as teclas cima e baixo quando tiver navegando pelos históricos de comando slavos no buffer. Uma vez feito isso você seleciona o comando do buffer e usa o comando `/` para que possa ser impresso o que foi retornado pelo comando `ed`. Ou seja, use o comando `ed`, faça as edições, salve e fecha o bloco de notas e uma vez que o cursor voltar a piscar no *sqlplus* digite `/` e após isso pressione **ENTER**, dessa forma você executa o conteúdo editado no buffer.

    ed
    [Faça as alterações no notepad, salve e feche o arquivo]
    /
    [ENTER]

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