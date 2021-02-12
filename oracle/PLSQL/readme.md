# PL/SQL
[DBMS_OUTPUT](https://docs.oracle.com/database/121/ARPLS/d_output.htm#ARPLS036)

01. [Básico](#exemplo-básico)

02. [Desvio Condicional](#desvio-condicional)

03. [Laço de repetições](#laço-de-repetições)

04. [SQL dentro de um bloco](#sql-dentro-de-um-bloco-plsql)

05. [Função](#função)

06. [Trigger](#trigger)

07. [Registros](#registro)

08. [Referenciando Tabelas](#rowtype)

09. [O Equivalente a Arrays](#type-table)  

10. [Cursores](#cursor) 

## Exemplo básico

### Tabela Bairro

     CREATE TABLE "SYSTEM"."BAIRRO" 
    (	"BAI_CODIGO" NUMBER(*,0), 
        "BAI_NOME" VARCHAR2(30 BYTE) NOT NULL ENABLE, 
        "BAI_DESCRICAO" VARCHAR2(20 BYTE), 
        PRIMARY KEY ("BAI_CODIGO")
    USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 
    STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
    PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
    TABLESPACE "SYSTEM"  ENABLE
    ) PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
    STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
    PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
    TABLESPACE "SYSTEM" ;

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
Aqui tem um exemplo mais avançado de [laços de repetição e procedure](bloco_procedure.sql)
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

## Função
### Criando uma função
    CREATE OR REPLACE FUNCTION funcao
    RETURN NUMBER
    IS
    BEGIN
      dbms_output.put_line('Ola Mundo');
      RETURN 1;
    END;

Essa é uma função, toda função deve retornar alguma coisa, logo para uma função essa clausura é obrigatório ` RETURN [tipo]`, sendo o `[tipo]` o dadao que a função deve retornar e nessa função temos esse retorno nesse ponto aqui `RETURN 1;`. Tirando esse detalhe do retorno, tudo é igual ao *procedure*. Ou seja:

    CREATE OR REPLACE FUNCTION [NOME]
    RETURN [TIPO]
    IS
    BEGIN      
      RETURN [VALOR];
    END;

`[NOME]` => Aqui você informa o nome da função.

`[TIPO]` => Que tipo de dado deve retornar.

`[VALOR]` => Dentro desse contexto o valor a ser retornado.

### Usando função dentro do SQL.
Você também pode usar uma função dentro de uma query *SQL*, `select * from bairro where bai_codigo = funcao()`. Além disso pode ser colocado em variávcel também:

    variable exemplo number;
    execute :exemplo := funcao();
    print :exemplo;

### Exemplo
Aqui tem um exemplo mais complexo envolvendo função [BHASKARA](bhaskara_function.sql)

## Trigger

Toda a trigger tem duas variáveis, que seria a `:old.[coluna]` e a `:new.[coluna]`, lembrando que a `.[coluna]` deve ser substitído pelo campo correspondente, a `:old.[coluna]` tem o valor antigo, o valor que estava no campo antes da trigger ser chamada, ao passo que `:new.[coluna]` tem o valor novo a ser inserido. No caso apenas o evento de `UPDATE` trabalha com as duas, o `DELETE` tem valor no `:old.[coluna]` e com o `:new.[coluna]` em branco, ao passo que o `INSERT` está na situação inversa, no caso sem valor no `:old.[coluna]` e apenas com valor em `:new.[coluna]`, essas variáveis são criadas de maneira automática dentro da Trigger e referenciam a tabela ao qual deve ser ponterada com o campo para que se faça alguma comparação ou interação. Porém as váriáveis `:new` e `:old` só estão disponíveis em triggers com `FOR EACH ROW` em sua composição, que são triggers que são executada a cada modificação, ao passo que uma *Trigger* sem essa marcação apenas executará a *trigger* uma vez e depois executa todas as mudanças, por exemplo em *triggers* aonde você modifica ou excluí um campo sem where, a cada atualização ou exclusão será executado se o `FOR EACH ROW` fizer parte da composição da *Trigger*, ao passo que quando essa marcação está omitida será executado ou antes de todo o processo ou depois de todo o processo de exclusão e atualização.
### Trigger de tabela
    
    CREATE OR REPLACE TRIGGER gatilho_basico
        AFTER INSERT OR UPDATE OR DELETE ON bairro
        BEGIN
            dbms_output.put_line('Valor');
        END;

Trigger são ativados antes ou depois de algum evento, *Triggers* sempre devem ser associado a alguma tabela e apenas pode ter uma trigger por evento, ou seja, se existe uma trigger que executa antes da inserção, não pode ter outra que execute no **before** do **insert**.

    CREATE OR REPLACE TRIGGER [NOME]
        [QUANDO] [EVENTO] 
        ON [TABELA]
        BEGIN
            [CODIGO]
        END;

`[NOME]` => Nome que você quer dar a **TRIGGER**.

`[QUANDO]` => Aqui é quando a *Trigger* deve ser executada, sendo as opçoes disponíveis: **BEFORE** para antes do evento e **AFTER** para depois do evento.

`[EVENTO]` => A que evento essa *trigger* vai ser chamado, podendo ser `INSERT`, `UPDATE` ou `DELETE`, pode ser um dois três, dois dos três ou para todos os três.

`[TABELA]` => A Tabela a ser monitorada.

`[CODIGO]` => O que deve ser feito quando essa trigger for ativada.

Lembrando que como não tem uma clausura `FOR EACH ROW` ou `WHEN` esse gatilho é disparado quando qualquer um dos campos for inserido, atualizado, ou excluído, conforme visto aqui `AFTER INSERT OR UPDATE OR DELETE ON bairro`.

### Excluíndo
Para excluir `drop trigger [NOME];`, substituíndo o `[NOME]` pelo nome da Trigger.
### Trigger para campos especifico

    CREATE OR REPLACE TRIGGER trigger_for_each_row
    BEFORE INSERT OR UPDATE OR DELETE
    OF bai_codigo
    ON bairro
    FOR EACH ROW 
    BEGIN

        IF :new.bai_codigo < 1 THEN
            raise_application_error(-20001,'ID deve ser maior ou igual a 1');
        ELSE
            dbms_output.put_line('O valor ANTIGO eh: '||:old.bai_codigo);
            dbms_output.put_line('O valor NOVO eh: '||:new.bai_codigo);
        END IF;

    END trigger_for_each_row;

Aqui temos um exemplo usando o `FOR EACH ROW` repare que se faz necessário essa clausura informando qual campo deve ser monitorado `OF bai_codigo`, ou seja:

    ...
    OF [COLUNA]
    ON [TABELA]
    FOR EACH ROW
    ...

`[COLUNA]` => Aqui é informado os campos a serem analizados pela trigger.

`[TABELA]` => A tabela deve ser informada.

**FOR EACH ROW** Aqui estamos indicando que a trigger funcionará apenas para a(s) coluna(s) informada.

### raise_application_error
Essa função lança um erro, seria o equivalente ao `throw new` das linguagens de programação, o primeiro argumento é o código de erro, que deve ser na casa dos `20000` para sinalizar erro customizável e sendo o segundo parametro a mensagem a ser exibida ao usuário, cujo o objetivo é informar que a inserção, atualização e exclusão quebra a regra de negócio imposta.

### Trigger condicional

    CREATE OR REPLACE TRIGGER trigger_for_each_row
    BEFORE INSERT OR UPDATE
        OF bai_codigo
        ON bairro
    FOR EACH ROW 
        WHEN (new.bai_codigo < 1)
    BEGIN  
        raise_application_error(-20001,'ID deve ser maior ou igual a 1');
    END trigger_for_each_row;

Essa trigger acima faz a mesma coisa que a acima, porém a lógica dessa trigger é vista aqui `WHEN (new.bai_codigo < 1)`, caso essa expressão seja verdadeira o código abaixo dela é executado, no caso esse código abaixo:

    BEGIN  
        raise_application_error(-20001,'ID deve ser maior ou igual a 1');
    END trigger_for_each_row;

### Trigger de Logon e Logoff
[Trigger Database](trigger_database.sql)

    -- LOGON
    CREATE OR REPLACE TRIGGER LOG_AFTER
    AFTER LOGON ON DATABASE
    BEGIN
        insert into logs values(log_seq.nextval,user,'IN',sysdate);
    END LOG_AFTER;

    -- LOGOFF
    CREATE OR REPLACE TRIGGER LOG_BEFORE
    BEFORE LOGOFF ON DATABASE
    BEGIN
        insert into logs values(log_seq.nextval,user,'OUT',sysdate);
    END LOG_BEFORE;

Você pode criar trigger `LOGON` quando o usuário entra e `LOGOFF` que é quando saí, lembrando que o `LOGON` deve ser sempre no `AFTER` uma vez que não existe antes de logar, assim como o `BEFORE` deve ser usado com o `LOGOFF`, ou seja na entrada deve ser no after, pois no antes estava deslogado da tabela, ou seja depois de logado e na saída deve ser sempre no before, pois no after o usuário estará fora.

**No oracle o `user` é uma variável do systema que retorna o nome do usuário, assim como o `sysdate` retorna a data atual.**

### Removing, inserting, updating

    CREATE OR REPLACE TRIGGER GATILHO
    AFTER INSERT OR UPDATE OR DELETE
    ON BAIRRO
    BEGIN
    IF INSERTING THEN
        DBMS_OUTPUT.PUT_LINE('VALOR INSERIDO');
    ELSIF UPDATING THEN
        DBMS_OUTPUT.PUT_LINE('VALOR ATUALIZADO');
    ELSIF DELETING THEN
        DBMS_OUTPUT.PUT_LINE('VALOR REMOVIDO');  
    ELSE
        DBMS_OUTPUT.PUT_LINE('none');  
    END IF;
    END GATILHO;

`IF INSERTING THEN` *=>* **Bloco executado caso a operação seja de inserção**.

`ELSIF UPDATING THEN` *=>* **Bloco executado caso a operação seja de atualização**.

`ELSIF DELETING THEN` *=>* **Bloco executado caso a operação seja de exclusão**.

### Desabilitando Trigger
`ALTER TRIGGER [NOME] DISABLE;`, o `[NOME]` deve ser substituída pelo correspondente, nesse caso a *TRIGGER* é desabilitada, no caso quando uma trigger é desabilitada, a mesma é ignorada quando o evento ao qual está registrado ocorre. 

### Habilitando Trigger
`ALTER TRIGGER [NOME] ENABLE;`, o `[NOME]` deve ser substituída pelo correspondente, no caso essa ativa uma trigger desabilitada pelo `DISABLE` [acima](#desabilitando-trigger).

## Registro

    DECLARE
    TYPE REGISTRO IS RECORD
    (
        COD INTEGER,
        VALOR VARCHAR2(30)
    );

    REG REGISTRO;
    BEGIN
        REG.COD := 1;
        REG.VALOR := 'OLA MUNDO';
        DBMS_OUTPUT.PUT_LINE(REG.COD || ', '|| REG.VALOR);
    END;

Os registros no *PL/SQL* funciona da mesma forma que no *C ANSI* ou no *PASCAL*, aqui é criado um novo tipo e o mesmo é usado para armazenar tipos de dados mais complexos, com uma anotação ponto. Sintaxe básica `TYPE REGISTRO IS RECORD([subnome] [subtipo]);` depois para usar `[nome] [novo_tipo_criado]`, para usar `[nome].[subnome]`.

`subnome` => O nome do atributo ao qual o registro contém.

`subtipo` => O tipo desse subatributo.

`[nome]` => o nome da variável

`[novo_tipo_criado]` => O tipo que você criou.

### Conceito

       DECLARE
    TYPE [NOVO_TIPO_CRIADO] IS RECORD
    (
        [SUBNOME] [SUBTIPO],
        [SUBNOME] [SUBTIPO]
    );

    [NOME] [NOVO_TIPO_CRIADO];
    BEGIN
        [NOME].[SUBTIPO] := [VALOR];
        [NOME].[SUBTIPO] := [VALOR];
        DBMS_OUTPUT.PUT_LINE([NOME].[SUBTIPO] || ', '|| [NOME].[SUBTIPO]);
    END;

## %ROWTYPE
###### Conceito
    DECLARE
        [NOME] [TABELA]%ROWTYPE;
    BEGIN
        SELECT * INTO [NOME] FROM [TABELA] WHERE [COLUNA] = [VALOR];  
        DBMS_OUTPUT.PUT_LINE([NOME].[COLUNA]);
    END;

O **%ROWTYPE** cria uma variável do tipo tabela, ou seja é possível fazer referência a toda uma tabela usando essa estratégia, lembrando que isso é válido se você quiser pegar todos os campos de uma tabela, do contrário dará erro, seria algo como `select * from` com clausura where, uma vez que isso não é um array. Se precisar que um ou outro campo seja excluído use [registros](#registro).

###### Exemplo
    DECLARE
        TAB BAIRRO%ROWTYPE;
    BEGIN
        SELECT * INTO TAB FROM BAIRRO WHERE BAI_CODIGO = 1;  
        DBMS_OUTPUT.PUT_LINE(TAB.BAI_CODIGO);
    END;

## Type Table
[Documentação](https://docs.oracle.com/cd/A57673_01/DOC/server/doc/PLS23/ch4.htm#plsql%20tabs)

    DECLARE 
        TYPE [NOVO_TIPO] IS TABLE OF [TIPO] INDEX BY [INDICE];
        [VARIAVEL] [NOVO_TIPO];
    BEGIN
        [VARIAVEL](1) := 'OLA';
        [VARIAVEL](2) := 'MUNDO';
        DBMS_OUTPUT.PUT_LINE([VARIAVEL](1) || ' - ' || [VARIAVEL](2));
    END;

`[NOVO_TIPO]` => Aqui você informa o nome que irá referenciar essa nova variável que está sendo criado.

`[TIPO]` => O tipo ao qual vai ser baseado.

`[VARIAVEL]` => A variável que vai usar esse novo tipo criado.

### Indice

`[INDICE]` => Uma coluna a ser escolida para ser usada como índice. 

#### BINARY INTEGER
> Com a Oracle Call Interface ou os Oracle Pré-compiladores, você pode vincular matrizes de host de escalares (mas não matrizes de host de estruturas) a tabelas PL / SQL declaradas como os parâmetros formais de um subprograma. Isso permite que você passe matrizes de host para funções e procedimentos armazenados. Você pode usar uma variável BINARY_INTEGER ou uma variável de host compatível para indexar os arrays de host. Dado o intervalo do subscrito da matriz m .. n, o intervalo do índice da tabela PL / SQL correspondente é sempre 1 .. n - m + 1. Por exemplo, se o intervalo do subscrito da matriz for 5 .. 10, o índice da tabela PL / SQL correspondente o intervalo é 1 .. (10 - 5 + 1) ou 1 .. 6.

> Para atribuir todos os valores em uma matriz de host a elementos em uma tabela PL / SQL, você pode usar uma chamada de subprograma. No exemplo Pro * C abaixo, você passa o salário da matriz de host para um bloco PL / SQL. Do bloco, você chama uma função local que declara a tabela PL / SQL sal_tab como um de seus parâmetros formais. A chamada de função atribui todos os valores no parâmetro real salary a elementos no parâmetro formal sal_tab.

No caso é o índice `BINARY INTEGER`, que faz com que esse tipo se comporte de uma maneira semelhante a um array de uma linguagem de programação tradicional, como no exemplo abaixo:

    DECLARE 
        TYPE TIPO IS TABLE OF VARCHAR2(40) INDEX BY BINARY_INTEGER;
        VARIAVEL TIPO;
    BEGIN
        VARIAVEL(1) := 'OLA';
        VARIAVEL(2) := 'MUNDO';
        DBMS_OUTPUT.PUT_LINE(VARIAVEL(1) || ' - ' || VARIAVEL(2));
    END;

**Output:** `OLA - MUNDO`.

Para se usar você referência os indices de um array com os parentes, como aqui `VARIAVEL(1)`, na prática, graças a indexação por inteiro binário, permite com que esse tipo se porte semelhante a um array, mas o tipo tabela não deve ser confundido a um array de uma linguagem de programação, pois a funcionalidade vai muito além disso, outra coisa essa parte `TYPE TIPO IS TABLE OF VARCHAR2(40) INDEX BY BINARY_INTEGER;`, poderia ser substituida por `TYPE TIPO IS TABLE OF [tabela]%type INDEX BY BINARY_INTEGER`; sem problemas, ou seja ali é aceito qualquer tipo, inclusive o tipo de colunas. Segue o exemplo abaixo usando o `%type`:

    DECLARE 
        TYPE TIPO IS TABLE OF BAIRRO.BAI_NOME%TYPE INDEX BY BINARY_INTEGER;
        VARIAVEL TIPO;
    BEGIN

        VARIAVEL(1) := 'OLA';
        VARIAVEL(2) := 'MUNDO';
        VARIAVEL(3) := '|';

        DBMS_OUTPUT.PUT_LINE('PRIMEIRO: '||VARIAVEL.FIRST);
        DBMS_OUTPUT.PUT_LINE('SEGUNDO: '||VARIAVEL(2));
        DBMS_OUTPUT.PUT_LINE('ULTIMO: '||VARIAVEL.LAST);

        -- VERIFICANDO SE DETERMINADO INDICE EXISTE
        IF VARIAVEL.EXISTS(2) THEN
            DBMS_OUTPUT.PUT_LINE('SIM O INDICE EXISTE');
        END IF;

        -- EXIBINDO A QUANTIDADE DE ELEMENTOS
        DBMS_OUTPUT.PUT_LINE('QUANTIDADE DE REGISTROS: '||VARIAVEL.COUNT);

        -- EXIBINDO O INDICE ANTERIOR E POSTERIOR AO INFORMADO.
        DBMS_OUTPUT.PUT_LINE('ANTERIOR AO SEGUNDO INDICE '||VARIAVEL.PRIOR(2)||', E O POSTERIOR '|| VARIAVEL.NEXT(2));

        -- EXCLUINDO E EXIBINDO A QUANTIDADE DE ELEMENTOS
            VARIAVEL.DELETE(3);
            DBMS_OUTPUT.PUT_LINE('QUANTIDADE DE REGISTROS AGORA: '||VARIAVEL.COUNT);
    END;

`[VARIAVEL].FIRST` => Pega o primeiro elemento.

`[VARIAVEL].LAST` => Pega o ultimo elemento.

`[VARIAVEL]([N])` => Pega o *N* elemento, sendo que o `[N]` deve ser substituído por um número.

`[VARIAVEL].EXISTS([N])` => Retorna um valor booleano, dizendo se o índice passado aqui `[N]` existe.

`[VARIAVEL].COUNT` => Informa a quantidade de elementos dentro da tabela criada.

`[VARIAVEL].PRIOR([N])` => retorna o índice anterior ao `[N]`.

`[VARIAVEL].NEXT([N])` => retorna o índice posterior ao `[N]`.

`[VARIAVEL].DELETE([N])` => excluí o elemento `[N]` da tabela, funciona de maneira semelhante ao *slice* dos arrays.

**O tipo de dados deve ser convertido para String, caso você deseja usa-lo para compor uma query, para isso pode ser `|| variavel([N])` ou `to_char(variavel[N]))`, sendo o `[N]` o índice.**

## Cursor
### SQL% - Básico
[Documentação](https://docs.oracle.com/cd/B19306_01/appdev.102/b14261/sql_cursor.htm)

    DECLARE 
        VARIAVEL NUMBER;
    BEGIN
        SELECT BAI_CODIGO INTO VARIAVEL FROM BAIRRO WHERE BAI_CODIGO = 1;
    
        -- VARIAVEIS DISPONIVEIS APOS QUALQUER PROJECAO.
        DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT);
        
        -- VERIFICANDO SE A CONEXAO ESTA ABERTA.
        IF SQL%ISOPEN THEN
            DBMS_OUTPUT.PUT_LINE('ABERTO');
        ELSE
            DBMS_OUTPUT.PUT_LINE('FECHADO');
        END IF;  
        
        -- VEFICANDO SE O REGISTRO FOI ENCONTRADO.
        IF SQL%FOUND THEN
            DBMS_OUTPUT.PUT_LINE('REGISTRO ENCONTRADO');
        END IF;    
    END;

`SQL%ROWCOUNT` => informa quantos registros foram retornados na ultima projeção.

`SQL%ISOPEN` => Verifica se o cursor está aberto, util apenas em uso de cursores.

`SQL%FOUND` => Verifica se a query retornou algum valor, util para o uso com cursores, também tem o que funciona com a lógica oposta, que é o `SQL%NOTFOUND`.

`SQL%BULK_ROWCOUNT` => Um atributo composto projetado para uso com a instrução `FORALL`. Este atributo atua como uma tabela index-by.Seu iésimo elemento armazena o número de linhas processadas pela iésima execução de uma instrução `UPDATE` ou` DELETE`.Se a iª execução não afetar nenhuma linha, `% BULK_ROWCOUNT (i)` retornará zero.

`SQL%BULK_EXCEPTIONS` => Um array associativo que armazena informações sobre quaisquer exceções encontradas por uma instrução `FORALL` que usa a cláusula` SAVE EXCEPTIONS`.Você deve percorrer seus elementos para determinar onde as exceções ocorreram e quais eram.Para cada valor de índice i entre 1 e `SQL% BULK_EXCEPTIONS.COUNT`,` SQL% BULK_EXCEPTIONS (i) .ERROR_INDEX` especifica qual iteração do loop FORALL causou uma exceção.`SQL% BULK_EXCEPTIONS (i) .ERROR_CODE` especifica o código de erro do Oracle que corresponde à exceção.

### Notas
>Você pode usar atributos de cursor em instruções procedurais, mas não em instruções SQL. Antes que o Oracle abra o cursor SQL automaticamente, os atributos implícitos do cursor retornam NULL. Os valores dos atributos do cursor sempre se referem à instrução SQL executada mais recentemente, onde quer que essa instrução apareça. Pode ser em um escopo diferente. Se você deseja salvar um valor de atributo para uso posterior, atribua-o a uma variável imediatamente.

> Se uma instrução SELECT INTO falhar em retornar uma linha, o PL / SQL levantará a exceção predefinida NO_DATA_FOUND, independentemente de você verificar SQL% NOTFOUND na próxima linha ou não. Uma instrução SELECT INTO que chama uma função de agregação SQL nunca gera NO_DATA_FOUND, porque essas funções sempre retornam um valor ou um NULL. Nesses casos, SQL% NOTFOUND retorna FALSE. % BULK_ROWCOUNT não é mantido para inserções em massa porque isso seria redundante, pois uma inserção típica afeta apenas uma linha. Consulte "Contando Linhas Afetadas por FORALL com o Atributo% BULK_ROWCOUNT".

> Você pode usar os atributos escalares% FOUND,% NOTFOUND e% ROWCOUNT com ligações em massa. Por exemplo,% ROWCOUNT retorna o número total de linhas processadas por todas as execuções da instrução SQL. Embora% FOUND e% NOTFOUND se refiram apenas à última execução da instrução SQL, você pode usar% BULK_ROWCOUNT para inferir seus valores para execuções individuais. Por exemplo, quando% BULK_ROWCOUNT (i) é zero,% FOUND e% NOTFOUND são FALSE e TRUE, respectivamente.

### Estrutura básica

    DECLARE
        CURSOR [SELECAO] IS [[SELECT [CAMPOS] FROM [TABELA] [WHERE] ]];
        [VARIAVEL] [SELECAO]%ROWTYPE;
    BEGIN
        OPEN [SELECAO];
        CLOSE [SELECAO];
    END;

`[SELECAO]` => Aqui você define o nome do cursor, lembrando sempre que ele deve ser aberto e fechado no corpo da procedure `OPEN [SELECAO];` e `CLOSE [SELECAO];`.

`[VARIAVEL]` => O cursor é um tipo e toda vez que você precisar pegar algum valor, você precisa usar essa referência.

#### [[SELECT [CAMPOS] FROM [TABELA] [WHERE] ]]
O cursor recebe sempre o resultado de um comando de projeção, no caso aqui entra os comandos de projeção usando o select.

#### Exemplo Básico
    DECLARE
        CURSOR SELECAO IS SELECT * FROM BAIRRO;
        SEL SELECAO%ROWTYPE;
    BEGIN
        OPEN SELECAO;
        CLOSE SELECAO;
    END;

#### FETCH
O **FETCH** seria o equivalente ao *Iterator*, e funciona de maneira semelhante ao *.next()*, no caso o FETCH ele vai populando uma variável a cada interação, segue a estrutura:

    DECLARE
        CURSOR [CURSOR_NOME] IS [QUERY_SELECT];
        [VAR] [CURSOR_NOME]%ROWTYPE;
    BEGIN
        OPEN [CURSOR_NOME];
        FETCH [CURSOR_NOME] INTO [VAR];
            DBMS_OUTPUT.PUT_LINE([VAR].[COLUNA]);
        CLOSE [CURSOR_NOME];
    END;

`[CURSOR_NOME]` => Nome do cursor, `[QUERY_SELECT]` => uma query de projeção do tipo *select*, `[VAR]` => faz referência ao resultado dentro do cursor, ou seja é aonde é armazenado o valor pego pelo *cursor*. No caso o que interessa ao **FETCH**:

    FETCH [CURSOR_NOME] INTO [VAR];
        DBMS_OUTPUT.PUT_LINE([VAR].[COLUNA]);
    CLOSE [CURSOR_NOME];

A cada interação o *FETCH* copula o `[VAR]` adicionando valor a ele, no caso o **FETCH** pegou o primeiro valor, geralmente se usa o **FETCH** dentro de algum laço de repetição, o seu funcionamento é semelhante ao **.next()** dos *iterators*, no caso inicialmente pega o primeiro valor, depois se chamado denovo pega o segundo, se chamado denovo pega o terceiro e por ai vai, no caso como foi chamado apenas uma vez, pega apenas o primeiro. outra coisa, o `[VAR]` representa a tupla atual da tabela, Agora nesse exemplo abaixo pega o primeiro e o segundo:

    DECLARE
        CURSOR SELECAO IS SELECT * FROM BAIRRO;
        SEL SELECAO%ROWTYPE;
    BEGIN
        OPEN SELECAO;
            FETCH SELECAO INTO SEL;
                DBMS_OUTPUT.PUT_LINE(SEL.BAI_NOME);
            FETCH SELECAO INTO SEL;
                DBMS_OUTPUT.PUT_LINE(SEL.BAI_NOME);  
        CLOSE SELECAO;
    END;

### FETCH dentro de LOOP

     OPEN [CURSOR];    
      LOOP
        FETCH [CURSOR] INTO [REFERENCIA];
        EXIT WHEN([REFERENCIA].BAI_CODIGO > 3);
            DBMS_OUTPUT.PUT_LINE(''||[REFERENCIA].BAI_NOME);        
      END LOOP;
    CLOSE [CURSOR];

A maneira mais útil de usar cursores é dentro de um laço, nesse caso você deve iniciar o laço com `LOOP` e encerrar com `END LOOP`, no caso a clausura `EXIT WHEN` determina qual é o critério de saida, no caso seria quando a coluna `BAI_CODIGO` tiver um valor maior que *3*, e ao chegar a esse valor encerra-se o laço, no caso cuidado para não dar um loop infinito, segue abaixo um exemplo mais prático:

    DECLARE
        CURSOR SELECAO IS SELECT * FROM BAIRRO;
        SEL SELECAO%ROWTYPE;
    BEGIN
        OPEN SELECAO;    
            LOOP
                FETCH SELECAO INTO SEL;
                EXIT WHEN(SEL.BAI_CODIGO > 3);
                DBMS_OUTPUT.PUT_LINE(''||SEL.BAI_NOME);        
            END LOOP;
        CLOSE SELECAO;
    END;

Também é possível usar os atributos de [SQL%](#sql---básico), porém isso deve ser feito dentro do bloco `OPEN [cursor]` e `CLOSE [cursor];`, exceto o usado para verificar se o cursor está aberto, segue um exemplo:

    DECLARE
        CURSOR SELECAO IS SELECT * FROM BAIRRO;
        SEL SELECAO%ROWTYPE;
    BEGIN
        OPEN SELECAO;
            -- LACO DE REPETICAO
            LOOP
                FETCH SELECAO INTO SEL;
                EXIT WHEN(SELECAO%NOTFOUND);
                DBMS_OUTPUT.PUT_LINE(''||SEL.BAI_NOME);        
            END LOOP;
            
            -- VERIFICANDO SE O CURSOR ESTA ABERTO
            IF SELECAO%ISOPEN THEN
                DBMS_OUTPUT.PUT_LINE('CURSOR ABERTO');
            END IF;           
            
            -- CONTANDO REGISTROS
            DBMS_OUTPUT.PUT_LINE('TEM '||SELECAO%ROWCOUNT||' REGISTROS');
        CLOSE SELECAO;      
    END;

No caso percebemos o uso disso aqui `SELECAO%NOTFOUND`, aqui `SELECAO%ISOPEN` e aqui `SELECAO%ROWCOUNT`, lembrando que essa **SELEÇÃO** deve ser o valor informado aqui `CURSOR SELECAO IS SELECT * FROM BAIRRO;` e não aqui `FETCH SELECAO INTO SEL;`, deve-se tomar cuidado para não confundir as coisas, uma vez que o `SQL%` guarda informações sobre a ultima projeção feita e no caso a projeção é salva no cursor conforme visto aqui `CURSOR SELECAO IS SELECT * FROM BAIRRO;` e não na referência ao cursor.