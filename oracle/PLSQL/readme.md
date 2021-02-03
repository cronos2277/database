# PL/SQL
[DBMS_OUTPUT](https://docs.oracle.com/database/121/ARPLS/d_output.htm#ARPLS036)

1.[Básico](#exemplo-básico)

2.[Desvio Condicional](#desvio-condicional)

3.[Laço de repetições](#laço-de-repetições)

4.[SQL dentro de um bloco](#sql-dentro-de-um-bloco-plsql)

## Exemplo básico

### Bloco Anônimo
    DECLARE
        variavel NUMBER;
    BEGIN
        variavel :=1;
        dbms_output.put_line('valor da variavel:' || variavel);
    END;

### DECLARE
Blocos anônimos são feitos com `DECLARE`, quando se faz necessário declarar variáveis, no caso a sintaxe lembra muito o `Pascal`, em declare você define as variáveis, no caso `[nome] [tipo]`, sendo que `[nome]` deve ser substituído pelo *nome da variável*, e o `[tipo]` pelo correspondente tipo, nesse caso `variavel NUMBER;` temos uma variável chamada *varivavel* do tipo *NUMBER*. O bloco pode ter o declare omitido se não houver declaração de variáveis, conforme a abixo:

    BEGIN
        dbms_output.put_line('Ola Mundo');
    END;

### Bloco BEGIN END.
Esse bloco é aonde contém a lógica do PLSQL a forma de se atribuir valores a variáveis é exatamente igual ao pascal `:=`, no caso aqui estamos atribuindo *1* a variável `variavel :=1;`.Todo bloco deve ter no mínimo o `BEGIN` e `AND`.

### dbms_output
Nesse pacote temos o `.put_line` que exibe o valor dentro dos parentes na tela. O DBMS é um pacote padrão do oracle database e o output tem o objetivo de imprimir no console para o usuário. Porém no **SQLPLUS** por padrão não funciona, logo você deve habilitar o **serveroutput** para *on* para que funcione e caso não esteja ativado basta informar no *sqlplus* `set serveroutput on`.

### Bloco nomeado
Blocos nomeados são *procedures* em português, procedimento.

    create or replace procedure exemplo
    is
        variavel VARCHAR2(40);
    BEGIN
        variavel := 'Ola mundo';
        dbms_output.put_line(variavel);
    END;

#### Criando
O bloco nomeado é um procedimento, no caso você pode criar um procedimento ou da forma que está ali `create or replace procedure [nome] is`, aonde `[nome]` deve ser substituído pelo respectivo nome, ou seja, em um bloco anônimo você usa o `DECLARE` e no bloco nomeado `create or replace procedure [nome] is` ou `create procedure [nome] is`, lembrando que o `create` apenas cria se não existir e da erro se existir a procedure ao passo que o `create or replace` cria se não existe ou substituí se existe.

#### Executando Procedure
`execute [nome]` toda a procedure você chama com o *execute* seguido do nome do procedure.

#### Excluíndo Procedure
Para excluir `drop procedure [nome]` aonde o `[nome]` deve ser substituído pelo valor correspondente.

### Procedure com argumentos

    create or replace procedure exibir (arg in varchar2)
    is        
    begin      
        dbms_output.put_line(arg);
    end;

    -- chamando
    execute exibir('Ola Mundo');

Para criar uma procedure você deve informar o nome do parametro seguido de in, que no caso seria uma abreviação para *input* e o tipo, `(arg in varchar2)`, assim como que para chamar, você deve informar os parâmetros também `execute exibir('Ola Mundo');`.

## Desvio Condicional
### Else/If

    create or replace procedure par_impar (arg in number)
    is        
    begin        
        if mod(arg,2) = 0 then
          dbms_output.put_line('Numero Par');
        else
          dbms_output.put_line('Numero Impar');
        end if;
    end;

Aqui temos um exemplo de `if/else` simples, aonde temos um bloco que contém o `if [expressão] then` abrindo o bloco e `end if;` para fechar o bloco, assim sendo, poderiamos omitir o else, ficando

    create or replace procedure [nome] ([parametro] in [tipo])
    is        
    begin        
        if [expressao] then
          [codigo]
        end if;
    end;

`[nome]` => Nome da procedure.

`[parametro]` => Nome do parametro que será usado dentro da procedure.

`[tipo]` => Tipo do argumento.

`expressão` => Aqui deve ter uma expresão booleana, cuidado aqui pois a sintaxe é diferente das linguagens e alguns operadores não funciona.

`[codigo]` => caso se a expressão for verdadeiro.

    create or replace procedure [nome] ([parametro] in [tipo])
    is        
    begin        
        if [expressao] then
          [codigo]
        else
          [ELSE]
        end if;
    end;

`[ELSE]` => código caso a expressão booleana seja falsa.

`mod(num1,num2)` => retorna o resto de divisão entre `num1/num2`.

### Elsif

    create or replace procedure dois_tres(arg in number)
    is        
    begin        
        if mod(arg,2) = 0 and mod(arg,3) = 0 then
          dbms_output.put_line('Divisivel por 2 e 3');
        elsif mod(arg,2) = 0 then
          dbms_output.put_line('Divisivel por 2');
	elsif mod(arg,3) = 0 then
          dbms_output.put_line('Divisivel por 3');
	else
	  dbms_output.put_line('Nao divisivel por 2 e 3');
        end if;
    end;

No caso quando temos mais de duas alternativas podemos usar o `elsif`, veja que é `elsif` e não `else if`, um `elsif` segue a mesma estrutura que o if.
    
    ...
        elsif [expressao] then
          [codigo]
	    elsif [expressao] then
          [codigo]
	...

### Switch-case no PL/SQL

    create or replace procedure opcoes(arg in number)
    is
    begin
    case
        when arg < 0 then 
            dbms_output.put_line('menor que zero');
        when arg > 0 then
            dbms_output.put_line('maior que zero');
        else
            dbms_output.put_line('valor zero');
    end case;
    end;

No caso do switch case abrimos um bloco com `case` e fecha-se o bloco com `end case;` no lugar do *switch* das linguagens de programação, ficando o `when` equivalente aos *case* da linguagem de programação, assim como o `else` toma o lugar do *default*. Cada *when* deve ser seguido por uma expressão booleana e da palavra reservada *then*.

    case
        when [expressao] then 
            [codigo]
        when [expressao] then
            [codigo]
        else
            [codigo]
    end case;

## Laço de Repetições
### Laço For
    declare
    begin
        for i in 1 .. 10
        loop
        dbms_output.put_line('tabuada do ' || i);
            for j in 1 .. 10
            loop
                dbms_output.put_line(i || ' x ' || j || ' = ' || (i*j) );
            end loop;
        end loop;
    end;

Aqui temos um exemplo de um laço for, no caso a variável *i* e *j* são criadas em tempo de execução, ou seja o próprio laço for cria essas variáveis, nesse caso temos um exemplo mais básico abaixo:

     for [variavel] in [inicio] .. [fim]
        loop
            [codigo]
        end loop;

a estrutura é *for* seguido do nome da variável a ser usada dentro do bloco for, *in* um número para início `..` e um número para o fim, lembrando que esse laço ele apenas trabalha com incremento do inicio ao fim, ou seja bem mais básico que os das linguagens de programação. Após isso tem um outro bloco interno que é o bloco `loop` e `end loop;`. Lembrando que o for executa todo o laço só para depois alterar o contador corrente.

`[variavel]` => Variavel de contador a ser usado dentro do bloco.

`[inicio]` => valor para iniciar a contagem.

`[fim]` => valor para encerrar a contagem.

`[codigo]` => Aqui está o código a ser repetido.

### While

    declare
        contador number := 1;
    begin
        while contador < 10
        loop
            dbms_output.put_line(contador);
            contador := contador + 1;
        end loop;
    end;

Esse é o exemplo mais básico do while, no caso aqui já definimos um valor padrão para a variável assim que o bloco se inicia `contador number := 1;`, o while diferente do *for* não possui um contador interno e conta com uma expressão booleana como critério de encerramento. `while [expressao] loop [codigo] end loop;`, lembre-se de incluir um contador, do contrário o laço pode ser infinito.

    while [expressao booleana]
        loop
            [codigo]
        end loop;

`[expressao booleana]` => Aqui deve estar o critério de parada.

`[codigo]` => o código a ser executado nesse laço.

### Exit when

    declare
        contador number := 1;
    begin
        while contador < 10
        loop
            dbms_output.put_line(contador);
            contador := contador + 1;
            exit when contador = 7;
        end loop;
    end;

No caso do código acima será exibido até o valor 6, uma vez que a expressão `exit when` funciona como uma espécie de *break* dentro de um bloco if. A sintaxe é `exit when [expressao booleana]`, sendo que aonde está a `[expressao booleana]` deve ser substituída pela expressão correspondente, desse modo o laço será interrompido, mesmo que a condição de parada do while não seja atingida, funcionando no caso como um break dentro de um if.

#### Exit

    declare
        contador number := 1;
    begin
        while contador < 10
        loop
            dbms_output.put_line(contador);
            contador := contador + 1;
            exit;
        end loop;
    end;

No caso o *exit* sem a expressão `when` funciona exatamente igual ao break das linguagens de programação, lembrando que o `exit` assim como qualquer laço pode funcionar em um bloco anônimo assim como em uma procedure.

### Variaveis Fora do Bloco
    variable ext varchar2(40);

    declare
    begin
        :ext := 'Valor';
    end;

    print ext;

Aqui temos a definição da variável `variable ext varchar2(40);`, abaixo temos a execução:

    declare
    begin
        :ext := 'Valor';
    end;

e por fim para exibirmos, temos o comando `print ext;`. Dessa forma você acessa uma variável global, ou seja fora do bloco, usando o variable para declarar, o print para visualiza e o `:[nome]`, sendo o `[nome]` o nome correspondente para ter acesso a variavel e modo que é possível passar valor a ela.


### OUT
    variable num1 NUMBER;

    CREATE OR REPLACE PROCEDURE INOUT (num OUT NUMBER)
    IS
    BEGIN
        num := 1;
    END;

    EXECUTE INOUT(:NUM1);

    PRINT NUM1;
#### Explicando   
Você pode definir uma variável dentro dos argumentos como *IN* ou *OUT*, por exemplo `CREATE OR REPLACE PROCEDURE INOUT (num OUT NUMBER)` o num aqui é uma variável de output. No caso um argumento dentro de uma procedure precisa ser informado se é um argumento de *INPUT* ou de *OUTPUT*, sendo o *IN* de input, significa que é um argumento que o procedimento vai receber para ser usado dentro do bloco, porém o *out* significa um output, ou seja que o procedimento vai modificar uma variável de escopo mais amplo, no caso a variável a ser modificado nesse exemplo, seria essa `variable num1 NUMBER;` e uma vez que o procedimento seja criado e executado, lembrando que parametros de out devem ser passados de maneira diferente `EXECUTE INOUT(:NUM1);`, repare que nesse caso, temos um dois pontos na frente da variável, seria como se estivessemos passando um valor por referência, logo todos os atributos de *out* deve ser informado usado dois pontos na frente. Uma vez executado, a variável tem o seu valor alterado, podendo ser conferido esse novo valor aqui `PRINT NUM1;`.

### Fechando bloco em específico

    CREATE OR REPLACE PROCEDURE INOUT (num OUT NUMBER)
    IS
    BEGIN
        num := 1;
    END INOUT;

A grande diferença se dá aqui `END INOUT;`, no caso você pode informar ao end, qual bloco está sendo fechado em qualquer procedure, afim de aumentar a legibilidade do código.  
## SQL dentro de um bloco PL/SQL

    DECLARE
        variavel Bairro.bai_nome%TYPE;
    BEGIN
        select bai_nome into variavel from bairro where bai_codigo = 2;
        dbms_output.put_line(variavel);
    END;
### Projetando em uma variável
Todo comando de projeção deve ser salvo em alguma variável e isso é feito nesse trecho de código `into variavel`, ou seja o resultado dessa query é colocado nessa variável e como é uma variável e não um array, se faz necessário que a query seja adaptada para retornar apenas um valor `where bai_codigo = 2;`. Porém isso se aplica a comando de projeção, comando DML ou DDL não precisa disso. Assim sendo:

    DECLARE
        [variavel] [Tipo];
    BEGIN
        select [coluna] into [variavel] from [tabela] [filtro];        
    END;

`[coluna]` => o nome da coluna na tabela.

`[variavel]` => Variável a ser armazeda o resultado da projeção.

`[tabela]` => A tabela ou view a ser projetada.

`[filtro]` => Clausuras SQL que fará com que a query retorne apenas um valor, ou a quantidade de variada definida.

### Projetando em mais variável
    DECLARE
        variavel Bairro.bai_nome%TYPE;
        codigo INTEGER;
    BEGIN
        select bai_codigo, bai_nome into codigo,variavel from bairro where bai_codigo = 2;
        dbms_output.put_line(codigo);
        dbms_output.put_line(variavel);
    END;

Você também pode especificar um tipo a variável, mas ele deve ser compoatível com o tipo da coluna, ao qual ele receberá os dados, logo é mais interessante usar o `%TYPE` e pegar otipo da coluna do que definir um tipo. Além disso é possível projetar valores a mais de uma variável, conforme visto aqui `select bai_codigo, bai_nome into codigo,variavel from bairro where bai_codigo = 2;`, como a query foi projetada para exibir dois valores, deve-se ter obrigatóriamente duas variáveis, assim sendo:

    select [coluna1], [coluna2] into [variavel1],[variavel2] from [tabela] [filtro];

Lembrando que o valor referente a *coluna1* será salvo a *variavel1* assim como a *coluna2* a *variavel2*, ou seja o lado direito do **into**, deve estar com as suas variáveis definidos de maneira sequencial, com base no lado esquerdo do **into**.
### %TYPE
Com essa expressão você pega o mesmo tipo de dados, que a coluna se mesma referencia, por exemplo `variavel Bairro.bai_nome%TYPE;` a variável terá o mesmo tipo que a coluna *bai_nome* da tabela de *bairro*, uma vez que o ponteramento é `[tabela].[coluna]` e com o `%TYPE` faz referência ao tipo.

### Usando funções

    DECLARE
        quantos number;
    BEGIN
        select count(bai_codigo) into quantos from bairro;
        dbms_output.put_line('Quantidade de registros: '||quantos);
    END;

Também é possível usar função na composição das queries, mas sempre que for executado uma query de projeção, sempre deve-se fazer uso de *into*, uma vez que é obrigatório.

### Inserindo dados.
    CREATE OR REPLACE PROCEDURE criar_bairro
    (
        nome in Bairro.bai_nome%type,
        codigo in Bairro.bai_codigo%type
    )
    is
    BEGIN
        insert into bairro (bai_codigo, bai_nome) values(codigo,nome);
        dbms_output.put_line(nome || ' inserido com sucesso!');
    END;

Repare que nesse *into* da query faz referência a query informada e não a uma imposição da linguagem *PL/SQL*, ou seja em comandos *DDL* e *DML*, não é preciso projetar o valor em algum lugar, isso se aplica apenas a comandos de projeção. Para executar essa procedure acima, basta `execute criar_bairro(nome,id);`.

### Atualizando

    CREATE OR REPLACE PROCEDURE atualizar_bairro
    (
        nome in Bairro.bai_nome%type,
        codigo in Bairro.bai_codigo%type
    )
    is
    BEGIN
        update bairro set bai_nome = nome where bai_codigo = codigo;
        dbms_output.put_line(nome || ' atualizado com sucesso!');
    END;

Repare que nessa query não tem o **into** `update bairro set bai_nome = nome where bai_codigo = codigo;`, ou seja isso é possível pelo fato de que não se trata de uma query de projeção.

### Excluíndo

    CREATE OR REPLACE PROCEDURE remover_bairro
    (  
    codigo in Bairro.bai_codigo%type
    )
    is
        nome Bairro.bai_nome%type;
    BEGIN
        select bai_nome into nome from bairro where bai_codigo = codigo;
        delete from bairro where bai_codigo = codigo;
        dbms_output.put_line(nome || ' exluido com sucesso!');
    END;

Também é possível colocar mais de uma query, no caso é projetado a variável `nome` o retorno da query e posteriormente executado a query de remoção de um determinado registro.