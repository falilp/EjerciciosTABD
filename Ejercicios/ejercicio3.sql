CREATE OR REPLACE TYPE tipoCuenta AS OBJECT(
    id NUMBER(4),
    valor NUMBER(11,2)
);

CREATE TABLE Cuenta OF tipoCuenta(
    CONSTRAINT PK_Cuenta PRIMARY KEY (id)
);

CREATE OR REPLACE TYPE tipoAcciones AS OBJECT(
    id NUMBER(4),
    idCuenta NUMBER(4),
    tipoOperacion CHAR(1),
    nuevoValor NUMBER(11,2),
    estado VARCHAR2(45),
    fechaModificacion DATE
);

CREATE TABLE Acciones OF tipoAcciones(
    CONSTRAINT PK_Acciones PRIMARY KEY (id)
);

INSERT INTO Cuenta (id, valor) VALUES (1, 1000.00);
INSERT INTO Cuenta (id, valor) VALUES (2, 2000.00);
INSERT INTO Cuenta (id, valor) VALUES (3, 1500.00);
INSERT INTO Cuenta (id, valor) VALUES (4, 6500.00);
INSERT INTO Cuenta (id, valor) VALUES (5, 500.00);

CREATE SEQUENCE SEQ_ACCIONES START WITH 1 INCREMENT BY 1 NOMAXVALUE;

INSERT INTO Acciones (id, idCuenta, tipoOperacion, nuevoValor, estado, fechaModificacion) VALUES (SEQ_ACCIONES.NEXTVAL, 3, 'a', 599, NULL, NULL);
INSERT INTO Acciones (id, idCuenta, tipoOperacion, nuevoValor, estado, fechaModificacion) VALUES (SEQ_ACCIONES.NEXTVAL, 6, 'i', 20099, NULL, NULL);
INSERT INTO Acciones (id, idCuenta, tipoOperacion, nuevoValor, estado, fechaModificacion) VALUES (SEQ_ACCIONES.NEXTVAL, 5, 'B', NULL, NULL, NULL);
INSERT INTO Acciones (id, idCuenta, tipoOperacion, nuevoValor, estado, fechaModificacion) VALUES (SEQ_ACCIONES.NEXTVAL, 7, 'A', 1599, NULL, NULL);
INSERT INTO Acciones (id, idCuenta, tipoOperacion, nuevoValor, estado, fechaModificacion) VALUES (SEQ_ACCIONES.NEXTVAL, 1, 'i', 399, NULL, NULL);
INSERT INTO Acciones (id, idCuenta, tipoOperacion, nuevoValor, estado, fechaModificacion) VALUES (SEQ_ACCIONES.NEXTVAL, 9, 'b', NULL, NULL, NULL);
INSERT INTO Acciones (id, idCuenta, tipoOperacion, nuevoValor, estado, fechaModificacion) VALUES (SEQ_ACCIONES.NEXTVAL, 10, 'h', NULL, NULL, NULL);

SET SERVEROUTPUT ON
DECLARE
    v_id Cuenta.id%TYPE := &id;
    
BEGIN
    FOR ACCION IN (SELECT * FROM Acciones) LOOP
        SELECT id INTO v_id FROM Cuenta WHERE id = ACCION.idCuenta;
        IF UPPER(ACCION.tipoOperacion) = 'I' OR UPPER(ACCION.tipoOperacion) = 'A' THEN
            IF v_id IS NULL THEN
                INSERT INTO Cuenta (id,valor) VALUES(ACCION.idCuenta,ACCION.nuevoValor);
                UPDATE Acciones SET estado = 'Operacion de inseccion con exito',fechaModificacion = SYSDATE WHERE id = ACCION.id;
            ELSE
                UPDATE Cuenta SET valor = valor + ACCION.nuevoValor WHERE id = v_id;
                UPDATE Acciones SET estado = 'Operacion de actualizacion con exito',fechaModificacion = SYSDATE WHERE id = ACCION.id;
            END IF;
        ELSIF UPPER(ACCION.tipoOperacion) = 'B' THEN
            IF v_id NOT NULL THEN
                DELETE FROM Cuenta WHERE id = v_id;
                UPDATE Acciones SET estado = 'Operacion de borrado con exito',fechaModificacion = SYSDATE WHERE id = ACCION.id;
            ELSE
                DBMS_OUTPUT.PUT_LINE('No se encontro ningun id para borrar');
            END IF;
        ELSE
            DBMS_OUTPUT.PUT_LINE('Operacion no valida');
        END IF;
    END LOOP;
END;