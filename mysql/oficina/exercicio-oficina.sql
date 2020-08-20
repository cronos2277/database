create database if not exists oficina;
use oficina;
create table carro(
    placa varchar(30) not null,    
    modelo varchar(30) not null,
    marca varchar(30) not null,
    data_entrada date not null    
);
create table cor(
    tonalidade varchar(30)
);
create table cliente(
    nome varchar(100) not null,
    cpf varchar(20) not null,
    data_nasc date
);
create table telefone(
    ddd char(2) not null,
    numero varchar(14) not null
);

create table tipo(
    tipo CHAR(3) not null
);

alter table carro add column id int primary key first;
alter table cor add column id int primary key first;
alter table cliente add column id int primary key first;
alter table telefone add column id int primary key first;
alter table tipo add column id int primary key first;

alter table carro add column fk_cliente int unique not null after id;
alter table cor add column fk_carro int not null after id;
alter table telefone add column fk_tipo int not null after numero;
alter table telefone add column fk_cliente int not null after fk_tipo;

alter table carro add constraint fk_cliente_carro foreign key(id) references cliente(id);
alter table cor add constraint fk_carro_cor foreign key(id) references carro(id);
alter table telefone add constraint fk_cliente_telefone foreign key(id) references cliente(id);
alter table telefone add constraint fk_tipo_telefone foreign key(id) references tipo(id);