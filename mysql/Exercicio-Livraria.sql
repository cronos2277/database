/* Criando database com dados. */
create database livraria;
use livraria;
CREATE TABLE livros (
    nome_do_livro varchar(30),
    nome_do_autor varchar(30),
    sexo_do_autor char(1),
    numero_de_paginas int(11),
    nome_da_editora varchar(30),
    valor_do_livro float(10,2),
    estado_da_editora char(2),
    ano_da_publicacao year(4)
);
INSERT INTO livros (nome_do_livro, nome_do_autor, sexo_do_autor, numero_de_paginas, nome_da_editora, valor_do_livro, estado_da_editora, ano_da_publicacao) VALUES
('Cavaleiro Real', 'Ana Claudia', 'F', 465, 'Atlas', 49.90, 'RJ', 2000),
('SQL para leigos', 'João Nunes', 'M', 450, 'Addison', 98.00, 'SP', 2018),
('Receitas caseiras', 'Ceila Tavares', 'F', 210, 'Atlas', 45, 'RJ', 2018),
('Pessoas efetivas', 'Eduardo Santos', 'M', 390, 'Beta', 78.99, 'RJ', 2018),
('Habitos Saudáveis', 'Eduardo Santos', 'M', 630, 'Beta', 150.98, 'RJ', 2019),
('A Casa Marrom', 'Hermes Macedo', 'M', 250, 'Bubba', 60, 'MG', 2016),
('Estacio Querido', 'Geraldo Francisco', 'M', 310, 'Insignia', 100, 'ES', 2015),
('Pra sempre amigas', 'Leda Silva', 'F', 510, 'Insignia', 78.98, 'ES', 2011),
('Copas Inesqueciveis', 'Marco Alcantara', 'M', 200, 'Larson', 130.98, 'RS', 2018),
('O poder da mente', 'Clara Mafra', 'F', 120, 'Continental', 56.58, 'SP', 2017);

/*Trazer todos os dados */
select * from livros;

/* Trazer o nome do livro e da editora. */
select nome_do_livro, nome_da_editora from livros;

/* Trazer nome do livro e a UF dos livros publicados por autores masculinos. */
select nome_do_livro,estado_da_editora from livros where sexo_do_autor = 'M';

/* Trazer o nome do livro e o numero de paginas dos livros publicados por autores do sexo feminino. */
select nome_do_livro, numero_de_paginas from livros where sexo_do_autor='F';

/* Trazer o valor dos livros publicados em Sao Paulo. */
select valor_do_livro from livros where estado_da_editora= "SP";

/*Somando os valores acima */ 
select sum(valor_do_livro) as `soma dos livros em SP` from livros where estado_da_editora= "SP";

/*Trazer dados dos autores do sexo masculino que tiveram livros publicados em SP ou RJ*/
select nome_do_autor from livros where sexo_do_autor="M" and (estado_da_editora="SP" or estado_da_editora="RJ");