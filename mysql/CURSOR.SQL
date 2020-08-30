CREATE DATABASE IF NOT EXISTS exemplo_cursor;
USE exemplo_cursor;
CREATE TABLE IF NOT EXISTS exemplo_cursor.exemplo (id INT PRIMARY KEY AUTO_INCREMENT, valor1 FLOAT(10,2),valor2 FLOAT(10,2),valor3 FLOAT(10,2));
CREATE TABLE IF NOT EXISTS exemplo_cursor.processo (id INT PRIMARY KEY AUTO_INCREMENT, soma FLOAT(10,2), media FLOAT(10,2), fk int);
ALTER TABLE processo ADD CONSTRAINT fk_exemplo_processo FOREIGN KEY (fk) REFERENCES exemplo(id);

DELIMITER $
CREATE PROCEDURE INSERIRDADOS()
BEGIN  
    DECLARE fkey,fim INT DEFAULT 0;
    DECLARE var1, var2, var3, vtotal, vmedia FLOAT(10,2);        

    DECLARE reg CURSOR FOR(     
        SELECT id,valor1, valor2,valor3 FROM exemplo_cursor.exemplo
    );

    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET fim = 1;

    OPEN reg;

    REPEAT
        FETCH reg INTO fkey,var1,var2,var3;
    IF NOT fim THEN
        SET vtotal = var1 + var2 + var3;
        SET vmedia = vtotal/3;    
        INSERT INTO exemplo_cursor.processo VALUES(NULL,vtotal,vmedia,fkey);
    END IF;
    UNTIL fim END REPEAT;
    CLOSE reg;

END$
DELIMITER ;