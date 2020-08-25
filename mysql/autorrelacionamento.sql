create database if not exists autorelacionamento;
use autorelacionamento;
create table if not exists curso(
    idcurso int primary key auto_increment,
    nome varchar(30),
    horas int,
    valor float(10,2),
    id_prereq int
);
alter table curso add constraint fk_cursos 
foreign key (id_prereq) references curso(idcurso);

insert into curso values(null, 'BD RELACIONAL',20,400.00,NULL);
insert into curso values(null, 'BUSSINESS INTELLIGENCE',40,800.00,1);
insert into curso values(null, 'RELATORIOS AVANCADOS',20,600.00,2);
insert into curso values(null, 'LOGICA PROGRAM',20,400.00,NULL);
insert into curso values(null, 'RUBY',30,500.00,4);
select c1.nome,c1.valor,c1.horas, ifnull(c2.nome,"SEM REQ") as requisitos from curso c1
left join curso c2 on c1.id_prereq = c2.idcurso;
