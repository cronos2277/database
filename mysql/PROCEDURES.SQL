CREATE DATABASE procedures;
USE procedures;

/*
    Para criar uma Procedure, voce precisa  saber que se faze necessario
    alterar o delimitador, por padrao o delimitador eh o ";", voce precisa
    alterar ele, caso queira criar uma procedure, uma vez que dentro da
    procedure exige-se a o uso de ponto e virgula para delimitar cada comando
    e com isso caso o delimitador nao seja modificado o mesmo pode executar
    o comando pela metade e dar erro. Repare que dentro do procedure havera
    ";", logo o caracter para sinalizar o fim da instrucao precisa mudar, 
    nesse caso usaremos o "$", use o comando abaixo se for fazer isso 
    no console do mysql, ja no phpmyadmin, lembre-se de mudar o delimitador
    no campo aonde isso aparece.
*/

DELIMITER $
CREATE PROCEDURE cria_tabelas()
BEGIN
    /*COMANDO DDL, criando tabela*/
    CREATE TABLE tabela1(id INT PRIMARY KEY,valor VARCHAR(30) NOT NULL);
    CREATE TABLE tabela2(id INT PRIMARY KEY,valor VARCHAR(30) NOT NULL,
        fk INT NOT NULL,FOREIGN KEY(fk) REFERENCES tabela1(id));
    /*COMANDO DML, inserindo valores padrao*/
    INSERT INTO tabela1 VALUES(1,"UM"),(2,"DOIS"),(3,"TRES"),(4,"QUATRO");
    INSERT INTO tabela2 VALUES(1,"A",1),(2,"B",2),(3,"C",3),(4,"D",4);
END$

/* 
    Para chamar a Procedura, usando o call voce chama uma procedure e 
faz com que ela seja executada. Como foi mudado o delimitador, logo temos
que substitui o ";" pelo delimitador setado no comando delimiter, no caso o $.
*/
CALL cria_tabelas()$
/*
    O cod se refere ao parametro do procedimento, ate aqui o seu funcionamento
    se assemelha a uma funcao e esse cod sera substituido pelo valor correspondente
    quando o procedimento for envocado. O "cod" esta se voce perceber a query
    na clausura where.
*/
CREATE PROCEDURE consultar_tabelas(cod INT)
BEGIN
    /*
        Voce tambem pode informar um parametro na sua procedure, seguindo a estrutura
        acima. Segue a mesma regra para definir atributos, porem sem as clausuras de
        restricoes quando se cria tabela e a estrutura de uma procedure se assemelha
        um pouco das funcoes no pascal, nos parenteses coloque um nome ao Parametro
        e o seu respectivo tipo.        
        Sempre eh bom ponterar valores, como no caso abaixo temos o t1 que se refere
        a tabela1 e o t2 que se refere a tabela2, isso ajuda a aumentar o desempenho,
        uma vez que o banco nao tera que gastar processamento para saber de qual
        tabela vem a coluna, e evita ambiguidades em tabelas diferentes que tem colunas com
        nomes iguais, como eh o caso sendo que ambas tem a coluna ID e Valor.       
    */
    SELECT t1.id, t1.valor,t2.valor
    FROM tabela1 t1
    INNER JOIN tabela2 t2
    ON t1.id = t2.id
    WHERE t1.id = cod;
END$

/*
    Para se chamar se assemelha a CALL acima, mas como essa tem um valor, logo se faz
    necessario informa-lo dentro dos parenteses.
*/
CALL consultar_tabelas(3)$

/*
    voce pode programar de uma maneira semelhante a uma funcao, toda a sequencia 
    de comando que o banco de dados precisa executar, quando esse procedimento
    for chamado, o procedimento pode ter parametros, que sera usados na composicao
    de uma Query, no caso esse 3 vai substituir a variavel ao qual ele corresponde
    na criacao do procedimento. Lmebre-se, procedimento nao eh funcao, apesar de
    estruturalmente se assemelhar a ela, procedimento nao retorna valores, diferente
    de funcoes que retornam valores, os procedimentos eles executam determinadas query
    e pronto. Voce tambem pode ter N parametros a serem passados ao procedimento, como
    no caso do procedimento abaixo.
*/

CREATE PROCEDURE altera_valor(cod INT, val VARCHAR(30))
BEGIN
    UPDATE tabela1 t SET t.valor = val WHERE t.id = cod; 
END$

/* Lembre-se sempre de chamar o procedimento atraves do CALL */
CALL altera_valor(2,"novo valor")$


/* 
    voce tambem pode apagar um procedimento usando um DROP PROCEDURE,
    lembre-se que aqui voce nao envoca o procedimento, logo sem (). 
*/
DROP PROCEDURE cria_tabelas$
/* Depois sera apagado a database e setado como delimitador o ";" denovo. */
DROP DATABASE procedures$
DELIMITER ;