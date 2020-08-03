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
('Cavaleiro Real', 'Ana Claudia', 'f', 465, 'Atlas', 49.90, 'RJ', 2000),
('SQL para leigos', 'João Nunes', 'M', 450, 'Addison', 98.00, 'SP', 2018),
('Receitas caseiras', 'Ceila Tavares', 'F', 210, 'Atlas', 45, 'RJ', 2018),
('Pessoas efetivas', 'Eduardo Santos', 'M', 390, 'Beta', 78.99, 'RJ', 2018);