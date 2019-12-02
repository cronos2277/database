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


