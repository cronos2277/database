create table exemplo_data(id int identity(1,1) primary key, aniversario date not null)
insert into exemplo_data values ('02/10/1990')
insert into exemplo_data values ('03/7/1994')
insert into exemplo_data values ('11/10/1989')
insert into exemplo_data values ('31/01/1998')

/* Pega data atual */
select getdate()

/* DATEDIFF no parametro day, faz calculos com dias*/
select aniversario, DATEDIFF(DAY,aniversario,getdate()) as "Dias Passados" from exemplo_data

/*DATEDIFF no parametro MONTH informa quandos meses se passou. */
select aniversario, DATEDIFF(MONTH,aniversario,getdate()) as "Meses Passados" from exemplo_data

/*Voce tambem pode usar com o parametro ano, assim será calculado quantos anos foram passados */
select aniversario, DATEDIFF(YEAR,aniversario,getdate()) as "Anos Passados" from exemplo_data

/* a funcao datename pega trechos de uma data completa. 
retorna um nvchar, se for um mes por exemplo o nome do mes */
select datename(MONTH,aniversario) as "DATENAME" from exemplo_data

/* a funcao pega trechos de uma data completa,  retorna um int, 
no caso se for um mes por exemplo retorna um numero de 1 a 12 de acordo com o mes*/
select datepart(MONTH,aniversario) as "DATEPART" from exemplo_data

/*
	Com dateadd voce faz operacoes com datas, no primeiro argumento voce passa
	o que voce quer calcular, ano, mes, dia, etc... no segundo quanto voce quer
	operar se eh aumentar um, diminuir um, etc... e por fim a data ao qual
	sera feita a operacao
*/
select dateadd(MONTH,-1,aniversario) as "DATEADD" from exemplo_data

/* Pega o dia */
select day('01/02/2000')

/* Pega o mes */
select month('01/02/2000')

/* Pega o ano */
select year('01/02/2000')
