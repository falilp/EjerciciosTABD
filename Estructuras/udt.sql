CREATE OR REPLACE TYPE tipoDireccion AS(
    calle VARCHAR2(32),
    numero NUMBER,
    localidad VARCHAR2(32),
    provincia VARCHAR2(32)
);

CREATE OR REPLACE TYPE tipoEmpresa AS OBJECT(
    nombre VARCHAR2(32),
    direccion tipoDireccion
);

-- Se pueden crear tablas a partir de tipos
CREATE TABLE Empresas OF tipoEmpresa;
CREATE TABLE Direcciones OF tipoDireccion;

-- Consultas:
SELECT * FROM Direcciones;
-- Produce tuplas como:
-- tipoDireccion("calle san juan", "33", "Cádiz", "Cádiz");