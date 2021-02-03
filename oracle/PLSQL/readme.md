# PL/SQL
[DBMS_OUTPUT](https://docs.oracle.com/database/121/ARPLS/d_output.htm#ARPLS036)

1.[Básico](#exemplo-básico)

2.[Desvio Condicional](#desvio-condicional)

3.[Laço de repetições](#laço-de-repetições)

## Exemplo básico

### Bloco Anônimo
    DECLARE
        variavel NUMBER;
    BEGIN
        variavel :=1;
        dbms_output.put_line('valor da variavel:' || variavel);
    END;

### DECLARE
Blocos anônimos são feitos com `DECLARE`, no caso a sintaxe lembra muito o `Pascal`, em declare você define as variáveis, no caso `[nome] [tipo]`, sendo que `[nome]` deve ser substituído pelo *nome da variável*, e o `[tipo]` pelo correspondente tipo, nesse caso `variavel NUMBER;` temos uma variável chamada *varivavel* do tipo *NUMBER*.

### Bloco BEGIN END.
Esse bloco é aonde contém a lógica do PLSQL a forma de se atribuir valores a variáveis é exatamente igual ao pascal `:=`, no caso aqui estamos atribuindo *1* a variável `variavel :=1;`

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