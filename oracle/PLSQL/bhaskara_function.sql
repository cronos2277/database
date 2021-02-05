CREATE OR REPLACE FUNCTION bascara
    (arg_a NUMBER, arg_b NUMBER, arg_c NUMBER)
    RETURN VARCHAR2
    IS
        delta NUMBER := 0;
        x1 NUMBER(10,2) := 0;
        x2 NUMBER(10,2) := 0;
    BEGIN    
        delta := (arg_b * arg_b) - 4*(arg_a*arg_c);    
        IF delta < 0 THEN
            RETURN 'NAO TEM RAIZ';
        ELSE
            delta := sqrt(delta);
            x1 := ((arg_b * -1) + delta )/(2* arg_a);
            x2 := ((arg_b * -1) - delta )/(2* arg_a);
            RETURN 'X1: '|| x1||', X2: '|| x2;
        END IF;
    END bascara;