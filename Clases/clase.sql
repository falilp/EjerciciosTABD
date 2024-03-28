-- Creación de la tipoClase
CREATE OR REPLACE TYPE tipoPersona AS OBJECT(
    id NUMBER,
    nombre VARCHAR2(32),
    fechaNacimiento DATE,
    profesion VARCHAR2(64)
);

-- Creación de la tabla de la clase y declaración de PK y unique
CREATE TABLE Persona OF tipoPersona(
    CONSTRAINT PK_Persona PRIMARY KEY (id),
    CONSTRAINT AK_Persona UNIQUE (nombre)
);


-- Atributos Compuestos
CREATE TYPE tipoDireccion AS OBJECT(   
    Calle VARCHAR2(32),
    Ciudad VARCHAR2(32)
);
CREATE OR REPLACE TYPE tipoPersona AS OBJECT(
    id NUMBER,
    nombre VARCHAR2(32),
    fechaNacimiento DATE,
    profesion VARCHAR2(64),
    direccion tipoDireccion
);

-- Atributos Multivaluados
CREATE TYPE tipoListaTelefono AS VARRAY(4) OF VARCHAR2(12);
CREATE OR REPLACE TYPE tipoPersona AS OBJECT(
    id NUMBER,
    nombre VARCHAR2(32),
    fechaNacimiento DATE,
    profesion VARCHAR2(64),
    listaTelefono tipoListaTelefono
);

-- Función
CREATE OR REPLACE TYPE tipoPersona AS OBJECT(
    id NUMBER,
    nombre VARCHAR2(32),
    fechaNacimiento DATE,
    profesion VARCHAR2(64),
    MEMBER FUNCTION edad RETURN NUMBER
);

CREATE OR REPLACE TYPE BODY tipoPersona IS 
    MEMBER FUNCTION edad RETURN NUMBER IS
    BEGIN
        RETURN EXTRACT(YEAR FROM SELF.fechaNacimiento);
    END;
END;