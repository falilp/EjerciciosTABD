SET SERVEROUTPUT ON
DECLARE
    v_temperatura REAL;
    v_escala CHAR(1);
    v_temperaturaAuxiliar REAL;
BEGIN
    v_temperatura := &temperatura;
    v_escala := UPPER('&escala');

    IF v_escala = 'C' THEN
        v_temperaturaAuxiliar := ((9/5)*(v_temperatura+32));
        DBMS_OUTPUT.PUT_LINE('La temperatura convertida a Fahrenheit es: ' || v_temperaturaAuxiliar);
    ELSIF v_escala = 'F' THEN
        v_temperaturaAuxiliar := ((5/9)*(v_temperatura-32));
        DBMS_OUTPUT.PUT_LINE('La temperatura convertida a Celsius es: ' || v_temperaturaAuxiliar);
    ELSE
        DBMS_OUTPUT.PUT_LINE('La escala ingresada no es la esperada');
    END IF;
END;