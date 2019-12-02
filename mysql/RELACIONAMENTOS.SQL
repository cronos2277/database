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
create table if not exists cidades(
    id int unsigned not null auto_increment,
    nome varchar(255) not null,
    estado_id int unsigned not null,
    area decimal(10,2),
    primary key(id),
    foreign key(estado_id) references estados (id)
);
