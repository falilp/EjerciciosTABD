CREATE OR REPLACE TYPE tipoDireccion AS(
    calle VARCHAR2(32),
    numero NUMBER,
    localidad VARCHAR2(32),
    provincia VARCHAR2(32)
);

CREATE OR REPLACE TYPE tipoPersona AS(
    nombre VARCHAR2(32),
    direccion REF tipoDireccion
);