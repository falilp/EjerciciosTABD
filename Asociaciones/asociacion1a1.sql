CREATE OR REPLACE TYPE tipoPersona AS OBJECT(
    id NUMBER,
    nombre VARCHAR2(32),
    fechaNacimiento DATE,
    profesion VARCHAR2(64),
    referenciaProyecto REF tipoProyecto
);

CREATE OR REPLACE TYPE tipoProyecto AS OBJECT(
    id NUMBER,
    tematica VARCHAR2(32),
    presupuesto NUMBER,
    referenciaPersona REF tipoPersona
);

CREATE TABLE Persona OF tipoPersona(
    CONSTRAINT PK_Persona PRIMARY KEY (id)
);

CREATE TABLE Proyecto OF tipoProyecto(
    CONSTRAINT PK_Proyecto PRIMARY KEY (id),
    referenciaPersona NOT NULL
);