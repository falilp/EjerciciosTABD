CREATE TABLE Persona(
    nombre VARCHAR22(32),
    listaTelefonos VARCHAR2(12) ARRAY[4]
);

CREATE SET CodigoCiudad(
    nombreCiudad VARCHAR2(32),
    codigo INTEGER
);

CREATE TABLE Persona(
    nombre VARCHAR(30),
    direccion SET (TipoDireccion),
    listaTelefonos VARCHAR(12) ARRAY[4]
);

CREATE LIST ListaParticipantes(nombre VARCHAR2(32));

-- Ejemplo de utilización de ELEMENT
INSERT INTO ListaParticipantes VALUES ("Javier") AFTER ELEMENT WHERE nombre = "Luis";