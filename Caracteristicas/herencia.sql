CREATE TABLE Persona(
    nombre VARCHAR2(32),
    sexo CHAR(1),
    edad NUMBER
);

CREATE TABLE Empleado UNDER Persona(sueldo FLOAT);

CREATE TABLE Cliente UNDER Persona(numeroCuenta NUMBER); 