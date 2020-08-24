CREATE DATABASE exemplo_backup;
USE exemplo_backup;
CREATE TABLE insercao (id INT PRIMARY KEY AUTO_INCREMENT, codigo INT NOT NULL,
                        valor VARCHAR(30) NOT NULL, 
                        usuario VARCHAR(30) NOT NULL,
                        horario DATETIME NOT NULL);
CREATE TABLE atualizacoes (id INT PRIMARY KEY AUTO_INCREMENT, codigo INT NOT NULL,
                            novo_valor VARCHAR(30) NOT NULL,
                            novo_antigo VARCHAR(30) NOT NULL, 
                            usuario VARCHAR(30) NOT NULL, 
                            horario DATETIME NOT NULL);
CREATE TABLE exclusoes ( id INT PRIMARY KEY AUTO_INCREMENT, codigo INT NOT NULL,
                        ultimo_valor VARCHAR(30) NOT NULL,
                        usuario VARCHAR(30) NOT NULL, 
                        horario DATETIME NOT NULL
                        );
CREATE DATABASE exemplo_original;
USE exemplo_original;
CREATE TABLE tabela(codigo INT PRIMARY KEY AUTO_INCREMENT, valor VARCHAR(30) NOT NULL);
/*
    Uma vez criado toda a parte de DDL Vamos para a Trigger de Insercao, a sintaxe
    para a criacao de uma trigger seria "CREATE TRIGGER nome_da_tabela" depois
    a que tempo pode ocorrer evento, existindo 6 possibilidades, sendo que nao pode
    haver mais de uma trigger para cada possibilidade dessa. No que tenge aos eventos
    temos (INSERT,UPDATE,DELETE) ou seja voce pode ativar quando um desses eventos
    forem executados, por fim temos o (AFTER,BEFORE), no caso do AFTER a trigger
    eh acionada depois do evento e o before antes. Ou seja toda vez que ocorrer
    uma criacao, modificacao ou exclusao, essa trigger pode ser executada antes
    ou depois. Depois temos o ON, que devemos informar em qual tabela deve ser
    monitorada. O "FOR EACH ROW" significa para cada linha, ou seja para cada
    vez que for executado o evento de insercao, exclusao ou atualizacao.  
    Voce deve avaliar de que o Before eh antes de salvar o dado na tabela,
    ou seja certos dados nao estao disponiveis quando a trigger before eh executada,
    por exemplo: para que a trigger tenha acesso ao PK por exemplo, a mesma precisa
    ser criada antes, logo talvez nesse caso seja necessario usar no evento after.
    NEW => Significa os novos dados que estao entrando, ou seja no trigger voce pode
    se referir aos dados novos usando o NEW. Por exemplo, se quer pegar o codigo
    entao voce poderia usar o NEW.codigo, com o new a trigger faz referencia ao 
    novo dado ao passo que o OLD faz referencia ao dado que sera substituido.
    No caso do Insert, como nao tem dado antigo, logo so se pode usar o operador NEW
*/
DELIMITER $
CREATE TRIGGER antes_inserir 
BEFORE INSERT 
ON tabela
FOR EACH ROW
BEGIN
    INSERT INTO exemplo_backup.insercao VALUES(NULL,NEW.codigo,NEW.valor,CURRENT_USER(),NOW());
END$
CREATE TRIGGER depois_inserir 
AFTER INSERT 
ON tabela
FOR EACH ROW
BEGIN
    UPDATE exemplo_backup.insercao b set b.horario = NOW();
END$
DELIMITER ;
INSERT INTO exemplo_original.tabela VALUES 
(1,"valor1"),(2,"valor2"),(3,"valor3"),
(4,"valor4"),(5,"valor5"),(6,"valor6");
/*
    Criando trigger para o evento de atualizacao, aqui fica
    mais claro sobre o NEW e o OLD, o new se refere ao dado
    que o usuario esta entrando e o OLD ao dado que esta no
    banco e sera substituido, o NEW. e o OLD. deve ser o
    prefixo do dado que voce deseja alterar No update, voce
    pode usar ambos, uma vez que nao existe OLD no insert
    e NEW no delete.
*/
DELIMITER $
CREATE TRIGGER antes_atualizar
BEFORE UPDATE
ON tabela
FOR EACH ROW
BEGIN
    INSERT INTO exemplo_backup.atualizacoes VALUES(NULL,NEW.codigo,NEW.valor,OLD.valor,CURRENT_USER(),NOW());
END$
CREATE TRIGGER depois_atualizar 
AFTER UPDATE 
ON tabela
FOR EACH ROW
BEGIN
    UPDATE exemplo_backup.atualizacoes b set b.horario = NOW();
END$
DELIMITER ;
UPDATE tabela SET valor = "MEU VALOR" WHERE codigo = 2;
UPDATE tabela SET valor = "MEU VALOR" WHERE codigo = 3;
/*
    Eventos de Exclusão.
    Quando voce for lidar com exclusao, use o old,
    uma vez que executado a query executada o valor equivalente a NEw
    em um evento de exclusao eh nada.
*/
DELIMITER $
CREATE TRIGGER antes_deletar
BEFORE DELETE
ON tabela
FOR EACH ROW
BEGIN
    INSERT INTO exemplo_backup.exclusoes VALUES(NULL,OLD.codigo,OLD.valor,CURRENT_USER(),NOW());
END$
CREATE TRIGGER depois_deletar 
AFTER DELETE 
ON tabela
FOR EACH ROW
BEGIN
    UPDATE exemplo_backup.exclusoes b set b.horario = NOW();
END$
DELIMITER ;
DELETE FROM tabela WHERE codigo = 1;
DELETE FROM tabela WHERE codigo = 4;

/*
    Apagando Triggers
*/
DROP TRIGGER antes_inserir;
DROP TRIGGER depois_inserir;
DROP TRIGGER antes_atualizar;
DROP TRIGGER depois_atualizar; 
DROP TRIGGER antes_deletar;
DROP TRIGGER depois_deletar;

/*
    Apagando DATABASE
*/

DROP DATABASE exemplo_backup;
DROP DATABASE exemplo_original;

/*
    Restricoes com triggers no MYSQL.
        * Nao se pode chamar diretamente um TRIGGER com CALL, como se faz com um Stored Procedures;
        * Nao eh permitido iniciar ou finalizar transacoes em meio a TRIGGERS;
        * Nao se pode criar um TRIGGERS para uma tabela temporaria – TEMPORARY TABLE;
        * TRIGGERS ainda nao podem ser implementadas com a intencao de devolver para o usuario ou para uma aplicacao mensagens de erros.        
*/