CREATE TYPE tipoListaPersonas AS TABLE OF REF tipoPersona;
CREATE TYPE tipoListaProyecto AS TABLE OF REF tipoProyecto;

CREATE OR REPLACE TYPE tipoPersona AS OBJECT(
    id NUMBER,
    nombre VARCHAR2(32),
    fechaNacimiento DATE,
    profesion VARCHAR2(64),
    listaProyecto tipoListaProyecto
);

CREATE OR REPLACE TYPE tipoProyecto AS OBJECT(
    id NUMBER,
    tematica VARCHAR2(32),
    presupuesto NUMBER,
    listaPersonas tipoListaPersonas
);

CREATE TABLE Persona OF tipoPersona(
    CONSTRAINT PK_Persona PRIMARY KEY (id)
)NESTED TABLE listaProyecto STORE AS Proyectos;

CREATE TABLE Proyecto OF tipoProyecto(
    CONSTRAINT PK_Proyecto PRIMARY KEY (id)
)NESTED TABLE listaPersonas STORE AS Personas;