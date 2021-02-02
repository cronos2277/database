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