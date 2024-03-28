CREATE TABLE empresa(
    nombre VARCHAR2(32),
    direccion ROW(
        calle VARCHAR2(32),
        numero NUMBER,
        localidad VARCHAR2(32),
        provincia VARCHAR2(32)
    )
);