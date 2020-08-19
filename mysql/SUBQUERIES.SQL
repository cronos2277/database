/*
    A subquery se faz necessario quando voce precisa comparar cada tupla
    com funcoes que retornam uma unica linha. Se voce usar uma funcao como
    essa, ela ira retornar o resultado mais a primeira tupla. Por exemplo
    Tomando o Banco de dados abaixo e aplicando a query: 
    "SELECT n.nome,MAX(n.salario) FROM exemplo n"
    Logo ao inves de retornar o nome de quem tem o maior salario, sera
    retornado o nome do primeiro registro ao lado do maior salario,
    gerando assim uma informacao errada, uma vez que o SELECT ele apenas
    projeta valores, nesse caso um nome e o maior salario e como a funcao
    apenas retorna um registro, logo ele retorna o maior salario com o
    nome da primeira tupla, o que eh uma informacao errada. Resumindo,
    para evitar esses problemas, se faz necessario usar uma subquery,
    nas subquery nos temos uma query interna e a externa. O resultado
    de uma subquery deve ser comparado com uma coluna ou mais da query
    externa usando a clausura where, por exemplo:
    SELECT e.id, e.nome,e.salario FROM exemplo e WHERE e.salario > ()
    Dentro dos parenteses voce deve colocar a subquery, essa eh a estrutura,
    repare que isso vai dentro dos parenteses e em comparacao com uma
    coluna usando de um filtro where, nao ha problemas a query interna
    retornar mais de uma tupla, porem a mesma deve retorna apenas uma
    coluna, uma vez que dado o contexto acima, nao se tem como comparar
    mais de um valor comparado com as colunas retornadas da query interna
    com uma unica coluna a esquerda do maior, seguindo esse exemplo.
    Em resumo:
    * A subquery deve ser usado toda vez que voce precisar comparar 
    uma funcao que retorna apenas um resultado com cada tupla, tipo
    AVG, SUM, COUNT, ou o NOW por exemplo.
    * A quantidade de colunas retornada pela query interna deve corresponder
    ao esperado pela coluna comparada com a clausura where.
    * A Query interna eh resolvida primeiro, ou seja a execucao das queries
    vai das mais internas as mais externas.
    * Os tipos comparados devem ser o mesmo, por exemplo evite comparar o
    e.salario por exemplo com uma coluna que sempre retorna String por exemplo.
*/

CREATE DATABASE IF NOT EXISTS subqueries;
USE subqueries;
CREATE TABLE IF NOT EXISTS exemplo(id INT PRIMARY KEY AUTO_INCREMENT,
                        salario FLOAT(10,2) NOT NULL,
                        nome VARCHAR(30));
INSERT INTO exemplo(nome,salario) VALUES("Jose",2500),("Marcia",2800),
("Pedro",3300),("Ana",4300),("Lucas",2700),("Maria",1800);

/* 
    A funcao max retorna o maior valor. A query abaixo retorna o nome da
    pessoa que tem o maior salario. Repare que a query interna retorna
    apenas uma coluna, o nome eh retornado apos a resolucao da query 
    interna.
*/
SELECT e.nome FROM `exemplo` e WHERE e.salario = (
        SELECT MAX(n.salario) FROM exemplo n
    );

/*
    A funcao MIN retorna o menor valor, a query abaixo retorna o nome e o 
    id da tupla com o menor salario. Detalhe isso apenas ocorre depois que
    a query interna seja resolvida.
*/
SELECT e.id,e.nome FROM `exemplo` e WHERE e.salario = (
        SELECT MIN(n.salario) FROM exemplo n
    );

/*
    A funcao AVG retorna a media aritimetica, no caso o WHERE eh analizado
    depois de resolvido a query interna, nesse caso a query retorna mais
    de uma tupla uma vez que existe 2 registros que atendam a condicao do
    where abaixo.
*/
SELECT e.id, e.nome,e.salario FROM exemplo e WHERE e.salario > (
    SELECT AVG(i.salario) FROM exemplo i
);

DROP DATABASE subqueries;

