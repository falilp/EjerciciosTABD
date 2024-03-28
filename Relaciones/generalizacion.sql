CREATE OR REPLACE TYPE tipoAlmacen AS OBJECT(
    id NUMBER,
    nombre VARCHAR2(32),
    FINAL MEMBER PROCEDURE auxiliar,
    MEMBER FUNCTION numeroEmpleados RETURN INTEGER
)NOT FINAL;

CREATE OR REPLACE TYPE tipoSeccion UNDER tipoAlmacen(
    tipo VARCHAR2(32),
    OVERRIDING MEMBER FUNCTION numeroEmpleados RETURN INTEGER
);