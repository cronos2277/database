/* Tudo que estiver em CAPS LOCK sao palavras reservadas do SGBD MySQL*/
CREATE DATABASE intermediario;
USE intermediario;

/* criando uma tabela, o AUto_INCREMENT eh exclusivo do Mysql. */
CREATE TABLE teste(codigo INT PRIMARY KEY AUTO_INCREMENT);

/*
    Uma forma de diferenciar o comando DDL de DML seria prestar a atencao
    na sintaxe, quando for DML: Insert, update, delete, DDL CREATE,ALTER,DROP.
    Insert quando for inserir dados na tabela, Create quando for criar a estrutura.
    Update quando for atualizar dados, Alter quando for atualizar a estrutura.
    Delete quando for deletar dados e Drop quando for excluir estruturas.
*/

/* 
    Aqui estamos criando um novo campo para a tabela. 
    A estrutura eh alter table <o nome da tabela> add <campo e as suas propriedades>
*/
ALTER TABLE teste ADD valor VARCHAR(30) NOT NULL;
ALTER TABLE teste ADD meexclua CHAR(1);
ALTER TABLE teste ADD meedita CHAR(1);
ALTER TABLE teste ADD meedita2 CHAR(1);

/*
    Aqui estamos deletando uma coluna, o comando funciona da seguinte forma:
    ALTER TABLE <nome da tabela> DROP <nome da coluna a ser excluida>.
    Cuidado com esse comando que ele exclui os dados da coluna tambem.    
*/
ALTER TABLE teste DROP meexclua;
/*
    Para alterar uma coluna podemos usar o change ou o modify, a grande diferenca
    entre eles eh a sintaxe. Com o Change voce precisa inserir uma informacao a mais.
    ALTER TABLE <tabela> CHANGE <nomeDaColuna> <NovoNome> <propriedades>;
    o CHANGE eh mais aconselhavel quando for renomear a coluna tambem.
*/
ALTER TABLE teste CHANGE meedita valor2 VARCHAR(30);

/*
    Agora quando voce opta por manter o mesmo nome o modify pode ser mais interessante,
    alem disso no MYSQL voce pode alterar a posicao da coluna na tabela, por padrao 
    a posicao da coluna na tabela eh por ordem de criacao, antes de executar a query
    abaixo a coluna eh a ultima a ser exibida nas projecoes usando o SELECT, ficando
    sempre mais a direita, mas voce pode manipular isso. No caso ao adicionar o FIRST
    depois de definir a modificacao da coluna, voce esta pedindo para essa coluna ser
    a primeira, caso voce queira que essa coluna seja a primeira, use o FIRST.
    ALTER TABLE <tabela> MODIFY <coluna> VARCHAR(30) FIRST;
*/
ALTER TABLE teste MODIFY meedita2 VARCHAR(30) FIRST;

/*
    Alem do FIRST temos o after, o after posiciona o campo da mesma maneira que faz
    o first, porem diferente do first, ele posiciona apos uma coluna especificada,
    como no exemplo abaixo que posiciona a coluna meedita2, que mudara de nome para
    valor3 e apos a coluna valor2.
*/
ALTER TABLE teste CHANGE meedita2 valor3 VARCHAR(30) AFTER valor2;
/* 
    Inserindo alguns valores na tabela. Preste a atencao no seguinte, repare que tem
    um valor nulo justamente no campo ao que se refere a chave primaria, no caso
    a chave primaria nessa parte do codigo eh o primeiro campo da tabela, logo
    o fato de estar sendo passado um valor nulo aqui, nao significa que a tabela
    aceita valor nulo como chave primaria e sim que eh para o banco de dado definir isso
    com base na estrategia de criacao de chaves primaria dele, nesse caso o "auto_increment".
    Nesse exemplo:
    INSERT INTO teste (codigo,valor, valor2, valor3) values(null, "valor1","valor2","valor3");
    Nesse caso voce poderia omitir o campo da chave primaria:     
    INSERT INTO teste (valor, valor2, valor3) values("valor1","valor2","valor3");
    Porem quando voce usa a forma abreviada, voce precisa informa os campos na ordem que foram
    criados e respeitando as manipulacoes feitas pelo FIRST e AFTER acima, logo como a chave 
    primaria eh o primeiro campo ela deve ser informada, mas como eh o banco que faz a criacao
    de chaves, logo voce passa um valor nulo e o auto_increment se incarrega de criar um id.
*/
INSERT INTO teste (codigo,valor, valor2, valor3) values(null, "valor0","valor0","valor0");
INSERT INTO teste values(null, "valor1","valor2","valor3");
INSERT INTO teste values(null, "valor4","valor5","valor6");
INSERT INTO teste values(null, "valor7","valor8","valor9");

/*
    Dessa forma criamos um VIEW, um view seria uma especie de atalho para queries, entao ao
    inves de digitar: "SELECT codigo,valor,valor2 AS "segundo", valor3 AS terceiro FROM teste ORDER BY codigo;"
    voce poderia simplesmente digitar: "select * from v_teste" ou fazer filtros nesse select, como por exemplo
    SELECT codigo,valor,valor2,valor3 FROM v_teste; No caso do select ele funciona como um ponteiro, que
    toda vez que chamado essa view seria como se chamasse a tabela original com aquela determinada query.
    Nesse exemplo o view ele reflete a tabela com 4 campos, com alias de segundo no campo valor2 e alias
    de terceira no campo aonde esta valor3, no caso o view seria uma tabela virtual com essas projecoes
    extras somadas. Alem disso tuda e qualquer atualizacao feita na view sera refletida na tabela original, mas
    lembre-se sempre que isso apenas funciona na atualizacao de valores, para criacao e exclusao ai temos um detalhe.
    Voce nao pode adicionar valores usando view ou excluir valores usando view, se e somente se tiver clausuras
    JOIN na view, ou seja se a View foi criada com alguma join, voce nao podera usar a view para fazer insercao
    ou exclusao, apenas selecao e atualizacao, agora no exemplo abaixo, como nao tem nenhum JOIN, logo essa
    restricao de exclusao e insercao nao se aplica. Evite de usar o select from *, isso afeta o desempenho do banco.
*/
CREATE VIEW v_teste AS SELECT codigo,valor,valor2 AS "segundo", valor3 AS terceiro FROM teste ORDER BY codigo;

/*
    Aqui estamos atualizando valores direto na view, repare que os campos utilizados aqui tem nomes diferentes
    ao da tabela original e isso se deve ao fato de que criamos um alias na criacao dessa view:    
    CREATE VIEW v_teste AS SELECT codigo,valor,valor2 AS "segundo", valor3 AS terceiro FROM teste ORDER BY codigo;
    Sempre use where quando usar update.
*/
UPDATE v_teste SET valor = 0,segundo = 0, terceiro = 0 WHERE codigo = 1;

/*
    Como essa view nao foi criada usada nenhuma clausura JOIN, logo podemos inserir e excluir dados atraves
    da VIEW sem problema algum, como no exemplo abaixo, mas lembre-se isso nao eh possivel em view que foi
    criada usada algum tipo de JOIN.
*/
DELETE FROM v_teste where codigo = 1;

/* 
    Dessa forma deletamos uma VIEW, como eh um comando DDL usamos o DROP e como v_teste eh view, 
usamos a palavra reservada VIEW
*/
DROP VIEW v_teste;

/* Apagando esse banco de dados, exclua essa parte se quiser manter*/
DROP DATABASE intermediario;