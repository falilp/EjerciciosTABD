-- 1 Crear tabla inventario
CREATE OR REPLACE TYPE tipoInventario AS OBJECT(
    id NUMBER,
    nombre VARCHAR2(64),
    unidades NUMBER,
    fechaModificacion DATE
);

CREATE TABLE Inventario OF tipoInventario(
    CONSTRAINT PK_Inventario PRIMARY KEY (id)
);

-- 2 Crear tabla control ventas
CREATE OR REPLACE TYPE tipoControlVentas AS OBJECT(
    id NUMBER,
    id_articulo REF tipoInventario,
    unidades NUMBER,
    fechaVenta DATE,
    comentario VARCHAR2(64)
);

CREATE TABLE ControlVentas OF tipoControlVentas(
    CONSTRAINT PK_ControlVentas PRIMARY KEY (id)
);

CREATE SEQUENCE SEQ_INVENTARIO START WITH 1 INCREMENT BY 1 NOMAXVALUE;
CREATE SEQUENCE SEQ_CONTROLVENTAS START WITH 1 INCREMENT BY 1 NOMAXVALUE;

-- 3 Intro filas en la tabla inventario
INSERT INTO Inventario (id,nombre,unidades,fechaModificacion) VALUES(SEQ_INVENTARIO.NEXTVAL,"pilas",20,SYSDATE);
INSERT INTO Inventario (id,nombre,unidades,fechaModificacion) VALUES(SEQ_INVENTARIO.NEXTVAL,"botellas",40,SYSDATE);
INSERT INTO Inventario (id,nombre,unidades,fechaModificacion) VALUES(SEQ_INVENTARIO.NEXTVAL,"cargadores",4,SYSDATE);
INSERT INTO Inventario (id,nombre,unidades,fechaModificacion) VALUES(SEQ_INVENTARIO.NEXTVAL,"ordenadores",20,SYSDATE);

-- 4 script PL/SQL anónimo que procese la orden de compra
SET SERVEROUTPUT ON
DECLARE
    v_ref tipoInventario;
    v_nombre Inventario.nombre%TYPE := '&nombre';
    v_unidades Inventario.unidades%TYPE := &cantidad;
    v_unidadesDisponibles Inventario.unidades%TYPE;
BEGIN
    SELECT REF(Inventario),unidades INTO v_ref,v_unidadesDisponibles FROM Inventario WHERE nombre = v_nombre;
    
    IF v_unidadesDisponibles >= v_unidades THEN
        UPDATE Inventario SET unidades = unidades - v_unidades, fechaModificacion = SYSDATE WHERE nombre = v_nombre;
        INSERT INTO ControlVentas (id,id_articulo,unidades,fechaVenta,comentario) VALUES(SEQ_CONTROLVENTAS.NEXTVAL,v_ref,v_unidades,SYSDATE,'Pedido satisfactorio');
        
        DBMS_OUTPUT.PUT_LINE('Orden de la compra satisfecha correctamente');
    ELSE
        INSERT INTO ControlVentas (id,id_articulo,unidades,fechaVenta,comentario) VALUES(SEQ_CONTROLVENTAS.NEXTVAL,v_ref,v_unidades,SYSDATE,'Pedido no satisfactorio por falta de stock');
        DBMS_OUTPUT.PUT_LINE('Orden de la compra no satisfecha por la falta de stock');
    END IF;
END;