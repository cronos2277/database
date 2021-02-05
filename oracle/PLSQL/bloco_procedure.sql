CREATE OR REPLACE PROCEDURE BLOCO
    (inicio IN INTEGER, fim IN INTEGER)
    IS
        auxiliar INTEGER := fim;
    BEGIN
        IF inicio > fim THEN  
            WHILE auxiliar <= inicio
            LOOP
                dbms_output.put_line('Numero: '||auxiliar);
                auxiliar := auxiliar + 1;
            END LOOP;   
        ELSE  
            FOR i in inicio .. fim
            LOOP
                dbms_output.put_line('Numero: '||i);
            END LOOP;    
        END IF;
    END BLOCO;