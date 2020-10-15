create table dados_originais (id smallint identity, valor varchar(30) not null, data datetime not null)
alter table dados_originais add constraint pk_original primary key(id)
GO

create table dados_backup (id bigint identity, fk smallint,valor_novo varchar(30), valor_antigo varchar(30) not null, criado datetime not null, ultima_mudanca datetime)
alter table dados_backup add constraint pk_backup primary key(id)
alter table dados_backup add constraint fk_original_backup foreign key (fk) references dados_originais(id)
GO

--Trigger insercao
create trigger trg_originais_backup_insert
on dbo.dados_originais
FOR INSERT
AS
	DECLARE @id smallint
	DECLARE @valor varchar(30)
	DECLARE @data datetime

	SELECT @id = id from inserted
	SELECT @valor = valor from inserted	
	SET @data = getdate()

	print 'Trigger de insercao executada!'
	insert into dados_backup (fk,valor_novo,valor_antigo,criado) values (@id,@valor,@valor,@data)
GO

drop trigger trg_originais_backup_insert 
GO

-- inserindo
insert into dados_originais(valor,data) values('Valor: '+cast(getdate() as varchar),getdate())
insert into dados_originais(valor,data) values('Valor: '+cast(getdate() as varchar),getdate())
insert into dados_originais(valor,data) values('Valor: '+cast(getdate() as varchar),getdate())
insert into dados_originais(valor,data) values('Valor: '+cast(getdate() as varchar),getdate())
insert into dados_originais(valor,data) values('Valor: '+cast(getdate() as varchar),getdate())
GO

-- Trigger para atualizar
create trigger trg_originais_backup_update
on dbo.dados_originais
FOR UPDATE AS
IF UPDATE(valor)
BEGIN
	DECLARE @id smallint
	DECLARE @novo_valor varchar(30)
	DECLARE @antigo_valor varchar(30)			

	SELECT @id = id from inserted
	SELECT @novo_valor = valor from inserted
	SELECT @antigo_valor = valor from deleted
	

	update dados_backup set valor_antigo = @antigo_valor where fk = @id
	update dados_backup set valor_novo = @novo_valor where fk = @id
	update dados_backup set ultima_mudanca = getdate() where fk = @id
	print 'Trigger de atualizacao executada!'
END
GO

-- atualizando
update dados_originais set valor='Valor: '+cast(getdate() as varchar), data = getdate() where id = 3
update dados_originais set valor='Valor: '+cast(getdate() as varchar), data = getdate() where id = 4
GO

-- Trigger para deletar
create trigger trg_originais_backup_delete
on dbo.dados_originais
FOR DELETE
AS
	DECLARE @id smallint
	SELECT @id = id from inserted	
	delete from dados_backup where id = @id
	print 'Trigger de exclusao executada!'
GO

delete from dados_originais where id = 2
GO

-- Selecao
select original.id,valor as 'Valor Original', data, valor_novo as 'Ultimo valor',
valor_antigo as 'Valor Anterior', criado, ultima_mudanca as 'Mudancas'
from dados_originais as original inner join dados_backup as bck
on original.id = bck.fk
GO
