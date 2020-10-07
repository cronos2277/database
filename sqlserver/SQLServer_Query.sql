/*
	Identity seria o equivalente ao auto_increment do SQL Server, mas com um diferencial,
	pois voce pode especificar a estrategia para a criacao de valor.
	O primeiro numero dentro do identity eh o numero inicial que sera usado, o segundo
	numero apos a virgula seria a estrategia de incremento, no caso essa identity
	abaixo que comeca em um e eh incrementado em 1.
*/

create table pessoa (
	id int identity(1,1),
	sexo char(1),
	nome varchar(100) not null,
	email varchar(50) not null
)
GO

/*SQL Server nao tem enum, logo voce cria uma enum dessa forma, atraves de um check. */
alter table pessoa add constraint check_sexo check (sexo in ('F','M'))
GO

alter table pessoa add constraint email_unique unique(email)
GO

alter table pessoa add constraint pessoa_pk primary key (id)
go

/*
	Voce pode informar que uma chave primaria ou estrangeira na criacao da tabela,
	mas isso nao eh recomendavel, pois o nome dessa relacao sera feito a cargo do
	banco de dados que escolhe um nome aleatorio e complexo para as relacoes, isso
	se aplica as restricoes como unique por exemplo, e a campos chaves como a
	chave primaria e estrangeira tambem.
*/
create table endereco(
	id int identity(1,1),
	fk int not null,
	rua varchar(50) not null,
	cidade varchar(20) not null,
	estado char(2) not null,
	foreign key (fk) references pessoa(id),
	primary key(id,fk) 
)
go

/* voce nao deve passar valores nos campos identity, o SQL Server faz isso sozinho. */
insert into pessoa values ('M','Joao','joao@email.com')
insert into pessoa values ('F','Maria','maria@email.com')
insert into pessoa values ('M','Carlos','carlos@email.com')
insert into pessoa values ('F','Ana','ana@email.com')
go

/* Trabalhando com subconsultas */
insert into endereco values ((select id from pessoa where nome = 'Joao'),'Rua das Neves', 'Carazinho', 'RS')
insert into endereco values ((select id from pessoa where nome = 'Maria'),'Rua Segundo', 'Curitiba', 'PR')
insert into endereco values ((select id from pessoa where nome = 'Carlos'),'Avenida da Arvore', 'Sao Paulo', 'SP')
insert into endereco values ((select id from pessoa where nome = 'Ana'),'Avenida Quinze', 'Rio de Janeiro', 'RJ')
go

/* Fazendo um inner join */
select p.id,p.sexo,p.email,e.rua,e.cidade,e.estado from pessoa p inner join endereco e on p.id = e.fk
go

select * from pessoa
go

drop table pessoa
go

drop table endereco
go


