-- o "if not exists" eh uma clausura que nao da erro caso a tabela ja exista.
-- Se nao existir ele cria, se existir ele simplesmente igonora, para isso
-- serve essa clausura, ela tambem serve com o DROP como sera explicado mais
-- adiante, sintaxe:
-- <CREATE OU DROP OU MODIFY> TABLE IF NOT EXISTS <TABELA> (<ATRIBUTOS SE NECESSIDADE>);

create table if not exists estados(    
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
    sigla varchar(2) NOT NULL,
    regiao ENUM('Norte','Nordeste','Centro-Oeste','Sudeste','Sul') NOT NULL,
    populacao DECIMAL(5,2) NOT NULL,
    PRIMARY KEY(id),
    UNIQUE KEY(nome),
    UNIQUE KEY(sigla)    
);
-- A questao do FOREIGN KEY, eh a chave estrangeira. No caso ela referencia
-- o ID de outra tabela, sintaxe:
-- FOREIGN KEY (<ID DA TABELA DE ORIGEM>) REFERENCES <TABELA>(<ID DA TABELA DESTINO>);
create table if not exists cidades(
    id int unsigned not null auto_increment,
    nome varchar(255) not null,
    estado_id int unsigned not null,
    area decimal(10,2),
    primary key(id),
    foreign key(estado_id) references estados (id)
);
-- Criando a tabela de teste caso nao exista.
create table if not exists teste(
    codigo int primary key,
    estado_id int unsigned not null,
    foreign key(estado_id) references estados (id)
);
-- Aqui deleta a tabela caso nao exista, repare que a logica aqui eh invertida.
-- Ou seja, se existir, apague a tabela.
drop table if exists teste;
-- Repare no id que eh colocado como valor do estado_id. Ali eh colocado 
-- um resultado de um select. Tudo que voce precisa fazer eh, primeiro se
-- certificar que o resultado do select eh apenas um valor e que esse valor
-- eh compativel com o tipo de dados e depois envolver esse select dentro de
-- parenteses. ficando por exemplo: 
-- INSERT INTO <TABELA> (<COLUNA>) VALUES ((<UM SELECT DE RETORNA UM VALOR COMPATIVEL>));
INSERT INTO `cidades` (NOME,ESTADO_ID,AREA)VALUES('CURITIBA',(SELECT ID FROM `estados` WHERE SIGLA = 'PR'),1030.32);
INSERT INTO `cidades` (NOME,ESTADO_ID,AREA)VALUES('Niteroi',(SELECT ID FROM `estados` WHERE SIGLA = 'RJ'),133.9);
INSERT INTO `cidades` (NOME,ESTADO_ID,AREA)VALUES('Campinas',(SELECT ID FROM `estados` WHERE SIGLA = 'SP'),795);
INSERT INTO `cidades` (NOME,ESTADO_ID,AREA)VALUES('Caruaru',(SELECT ID FROM `estados` WHERE SIGLA = 'PE'),795);
create table if not exists prefeitos(
    id int unsigned not null auto_increment,
    nome varchar(255) not null,
    cidade_id int unsigned,
    primary key (id),
    unique key (cidade_id),
    foreign key (cidade_id) references cidades (id)
);

insert into prefeitos (nome,cidade_id)
values
    ('Rodrigo Neves',2),
    ('Raquel Lyra',4),
    ('Zenaldo Coltinho',null);
insert into prefeitos(nome,cidade_id)
values
    ('Rafael Greca',null);
-- A respeito dos JOINS.
-- INNER JOIN => pega a interseccao das tabelas.
-- AUTER JOIN => eh o oposto da inner join, pega todos 
-- os valores que nao sejam interseccao das tabelas.
-- LEFT JOIN => Pega todos os valores com base na tabela a esquerda.
-- RIGHT JOIN => Pega todos os valores com base na tabela a direita.
-- FULL JOIN => Nao presente nativamente no mysql, pega todos os valores,
-- presente em todas as tabelas.
-- Exemplo de INNER JOIN:
-- SINTAXE SELECT <COLUNAS> FROM <TABELA ESQUERDA> 
-- INNER JOIN <TABELA DIREITA> ON 
-- <COLUNA DE UMA DAS TABELAS> = <COLUNA DE UMA DA OUTRA TABELA>;

-- INNER JOIN, repare que o resultado eh apenas os valores relacionados,
-- sendo ignorado o valor nulo, ou ate mesmo os valores nao relacionados.
select * from cidades inner join prefeitos on cidades.id = prefeitos.cidade_id;

-- LEFT JOIN, nesse caso eh priorizado a tabela a esquerda em detrimento
-- da tabela da direita. Na esquerda e tendo ou nao relacionamento e 
-- tudo que esta a esquerda sera mostrado, diferente do inner que so mostra
-- os relacionados, esse mostra todos os da esquerda.
select * from cidades left join prefeitos on cidades.id = prefeitos.cidade_id;

-- RIGHT JOIN, nesse caso eh priorizado a tabela a direita em detrimento
-- da tabela da esquerda. Na direita e tendo ou nao relacionamento e 
-- tudo que esta a esquerda sera mostrado, diferente do inner que so mostra
-- os relacionados, esse mostra todos os da direita.
select * from cidades right join prefeitos on cidades.id = prefeitos.cidade_id;

-- FULL JOIN, nao funciona nativamente no MYSQL, mas eh possivel usalo,
-- atraves da clausura UNION. Alem disso voce pode colocar mais uma clausura
-- no UNION, ficando UNION ALL, nesse caso permitindo duplicacoes, sem isso
-- nao sera exibido as duplicacoes.
select * from cidades left join prefeitos on cidades.id = prefeitos.cidade_id
UNION
select * from cidades right join prefeitos on cidades.id = prefeitos.cidade_id;