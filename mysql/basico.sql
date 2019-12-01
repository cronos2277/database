
-- <= comentario no  MYSQL, ; separa uma instrucao da outra, sendo opcional caso tenha
-- uma instrucao individual, mas apenas nesse caso em especifico.

-- Com esse comando voce pode selecionar o banco de dados que deseja utilizar via cli.
use wm;
-- Criando a tabela estado Comentario
-- Para criar uma tabela precisa da palavra create e depois table.
-- depois do create table abrimos os parenteses e colocamos dentro
-- deles as colunas e o tipo de dado que vai ter dentro dessa tabela.
-- Com relacao a o inteiro temos o INT que nesse caso poderiamos
-- colocar um tamanho nele tipo, por exemplo: id INT(10).

-- o AUTO_INCREMENT = ele se incrementa sozinho, ou seja esse valor
-- eh preenchido automaticamente pelo banco de dados, o mesmo pode
-- ser usado como uma chave sintetica.

-- INT => Um tipo de dado inteiros,
-- no caso quando nao informado o tamanho se usa o padrao.

-- UNSIGNED => Sem sinal, ou seja apenas recebe positivos.

-- NOT NULL => Obrigatorio, os dados sinalizados com NOT NULL, 
-- nao pode ficar sem ser preenchido na hora de inserir dados.

-- AUTO_INCREMENT => No caso do Mysql o banco de dados preenche esse valor,
-- usando o numero anterior +1.

-- VARCHAR(TAMANHO) => Eh como se fosse uma String, 
-- mas com o numero maximo definido dentro dos parenteses.

-- ENUM('DadoPermitido1','DadoPermitido2') => Eh um tipo de dados,
-- que voce pode apenas colocar apenas os valores permitidos,
-- que sao os de dentro dos parenteses.

-- DECIMAL(QuantidadeMaximaDeDigitos,NumeroDeCasaDecimal).
-- Esse serve para criar numeros decimais.

-- PRIMARY KEY(coluna) => Aqui informa qual coluna eh o ID.
-- UNIQUE KEY(coluna) => Aqui voce informa qual campo nao aceita duplicidade,
-- os valores informados aqui devem ser unicos.
-- uso: CREATE TABLE <NOMETABELA>(coluna_nome1 TIPO e OPCOES, coluna_nome2 TIPO e OPCOES);
-- Por padrao se usa maiusculo nos comandos, mas isso eh apenas convencao, pois o mesmo eh
-- case insensitive, ao menos o MYSQL.
create table estados (    
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
    sigla varchar(2) NOT NULL,
    regiao ENUM('Norte','Nordeste','Centro-Oeste','Sudeste','Sul') NOT NULL,
    populacao DECIMAL(5,2) NOT NULL,
    PRIMARY KEY(id),
    UNIQUE KEY(nome),
    UNIQUE KEY(sigla)    
);
-- Aqui abaixo temos um exemplo do comando insert into. Sendo a sua sintaxe:
-- INSERT INTO <TABELA> (CAMPOS) VALUES ('VALORES') => Apenas os valores com aspas, os campos nao.
-- Voce tambem pode omitir na sintaxe os campos, caso voce coloque todos os valores e 
-- sequencialmente os valores na ordem que foram criados no create table. Por exemplo:
-- INSERT INTO <TABELA> VALUES (PRIMEIRO_ATTR,SEGUNDO_ATTR,ETC...); Essa seria a forma resumida.
-- Com relacao a valores lembre-se sempre de por strings dentro de aspas.
insert into estados(nome,sigla,regiao,populacao) values ('Acre','AC','NORTE',0.83);
-- Exemplo da segunda sintaxe, repare que ai embaixo eu tive que incluir o ID:
insert into estados values (2,'Alagoas','AL','NORDESTE',3.38);
-- Voce tambem pode colocar mais de um valor por vez, mas use a virgula como separador:
insert into estados(nome,sigla,regiao,populacao) values 
('Amapa','AP','NORTE',0.8),('Amazonas','AM','NORTE',4.06);
