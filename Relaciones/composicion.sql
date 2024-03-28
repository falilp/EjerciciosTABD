CREATE OR REPLACE TYPE tipoDepartamento AS OBJECT(
    id NUMBER,
    nombre VARCHAR2(32)
);

CREATE OR REPLACE TYPE tipoListaDepartamentos AS TABLE OF tipoDepartamento;

CREATE OR REPLACE TYPE tipoEmpresa AS OBJECT(
    id NUMBER,
    nombre VARCHAR2(32),
    listaDepartamentos tipoListaDepartamentos
);

CREATE TABLE Departamento OF tipoDepartamento(
    CONSTRAINT PK_Departamento PRIMARY KEY (id)
);

CREATE TABLE Empresa OF tipoEmpresa(
    CONSTRAINT PK_Empresa PRIMARY KEY (id)
)NESTED TABLE listaDepartamentos STORE AS Departamentos;

-- Ejemplo de inserción/consulta
INSERT INTO Empresa VALUES(tipoEmpresa(1, "Sistemas Informáticos", …, tipoListaDepartamentos(tipoDepartamento(1, "Desarrollo", …))));

SELECT T1.IDEmpresa, T1.Nombre, T2.IDDepartamento
FROM Empresa T1, TABLE(T1.Tiene_Dptos) T2;