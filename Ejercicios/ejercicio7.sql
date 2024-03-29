CREATE OR REPLACE TYPE tipoEmpleados AS OBJECT(
    id NUMBER,
    codigoEmpleado NUMBER,
    nombre VARCHAR2(32),
    sueldo NUMBER
);

CREATE TABLE Empleados OF tipoEmpleados(
    CONSTRAINT PK_Empleados PRIMARY KEY (id)
);

CREATE OR REPLACE TYPE tipoRegistro AS OBJECT(
    id NUMBER,
    codigoEmpleado NUMBER,
    nombre VARCHAR2(32),
    fecha DATE,
    accion VARCHAR2(8),
    atributo VARCHAR2(16),
    valorAnterior VARCHAR2(16),
    valorActual VARCHAR2(16)
);

CREATE TABLE Registro OF tipoRegistro(
    CONSTRAINT PK_Registro PRIMARY KEY (id)
);

SET SERVEROUTPUT ON;

CREATE SEQUENCE MODIFICACIONES START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER controlModificaciones
BEFORE INSERT OR UPDATE OR DELETE ON Empleados
FOR EACH ROW
DECLARE
    v_accion VARCHAR2(8);
BEGIN
    IF INSERTING THEN
        v_accion := 'insert';
    ELSIF UPDATING THEN
        v_accion := 'update';
    ELSIF DELETING THEN
        v_accion := 'delete';
    END IF;
    
    :NEW.codigoModificacion := MODIFICACIONES.NEXTVAL;
    INSERT INTO Registro(id,codigoEmpleado,nombre,fecha,accion) VALUES(:NEW.codigoModificacion,:NEW.codigoEmpleado,USER,SYSDATE,v_accion);

    IF UPDATING THEN
        IF :OLD.nombre != :NEW.nombre THEN
            UPDATE Registro SET atributo = 'nombre', valorAnterior = :OLD.nombre, valorActual = :NEW.nombre WHERE id = :NEW.codigoModificacion;
            DBMS_OUTPUT.PUT_LINE('Actualizacion de nombre valida');
        ELSIF :OLD.sueldo != :NEW.sueldo THEN
            UPDATE Registro SET atributo = 'sueldo', valorAnterior = :OLD.sueldo, valorActual = :NEW.sueldo WHERE id = :NEW.codigoModificacion;
            DBMS_OUTPUT.PUT_LINE('Actualizacion de sueldo valida');
        ELSE
            DBMS_OUTPUT.PUT_LINE('El valor actualizado no es valido');
        END IF;
    END IF;
END;