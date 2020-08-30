CREATE DATABASE IF NOT EXISTS exemplo_cursor;
USE exemplo_cursor;
CREATE TABLE IF NOT EXISTS exemplo_cursor.exemplo (id INT PRIMARY KEY AUTO_INCREMENT, valor1 FLOAT(10,2),valor2 FLOAT(10,2),valor3 FLOAT(10,2));
CREATE TABLE IF NOT EXISTS exemplo_cursor.processo (id INT PRIMARY KEY AUTO_INCREMENT, soma FLOAT(10,2), media FLOAT(10,2), fk int);
ALTER TABLE processo ADD CONSTRAINT fk_exemplo_processo FOREIGN KEY (fk) REFERENCES exemplo(id);

/*
    Aqui começamos a criar o nosso cursor, repare que fazemos isso dentro de
    uma procedure.
*/
DELIMITER $
CREATE PROCEDURE INSERIRDADOS()
BEGIN  
    /*
        Dessa forma declaramos uma variável, o tipo das variaveis precisam ser compativeis
        com os retornos dos seletores, que as irao preencher.
    */
    DECLARE fkey,fim INT DEFAULT 0;
    DECLARE var1, var2, var3, vtotal, vmedia FLOAT(10,2);        

    DECLARE reg CURSOR FOR(     
        /*
            Aqui estamos criando um cursor, seu conteudo sera o retorno desse select.
        */
        SELECT id,valor1, valor2,valor3 FROM exemplo_cursor.exemplo
    );

    /* 
        Aqui estamos impondo uma condicao ao registro, quando a variavel fim for preenchida,
        a execução se encerra.
    */
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET fim = 1;

    OPEN reg; /*Aqui estamos abrindo o cursor*/

    REPEAT /*laco de repeticao*/
        FETCH reg INTO fkey,var1,var2,var3; /*Aquie estamos preenchendo as variaveis com valores.*/
    IF NOT fim THEN /* Enquanto o laco funcionar... */
        SET vtotal = var1 + var2 + var3; /* Aqui temos a logica de criar o vtotal*/
        SET vmedia = vtotal/3;    /* Aqui temos a logica de criar o vmedia*/
        INSERT INTO exemplo_cursor.processo VALUES(NULL,vtotal,vmedia,fkey); /*Inserindo na tabela*/
    END IF; /*Fim do if*/
    UNTIL fim END REPEAT; /*fim do repeat. */
    CLOSE reg; /* Aqui estamos fechando um cursor, nunca esqueca disso.*/

END$
DELIMITER ;