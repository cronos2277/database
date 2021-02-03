# PL/SQL
[DBMS_OUTPUT](https://docs.oracle.com/database/121/ARPLS/d_output.htm#ARPLS036)

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