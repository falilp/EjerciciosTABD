CREATE OR REPLACE TYPE tipoDepartamento AS OBJECT(
    id NUMBER,
    nombre VARCHAR2(32)
);

CREATE OR REPLACE TYPE tipoListaDepartamentos AS TABLE OF REF tipoDepartamento;

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

-- Ejeplo de insección
INSERT INTO Departamento VALUES (tipoDepartamento(1, "Planificación", …));
INSERT INTO Departamento VALUES (tipoDepartamento(2, "Producción", …));
-- Inserta una empresa formada por estos dos Departamentos

DECLARE

D1_Ref REF tipoDepartamento;
D2_Ref REF tipoDepartamento;

BEGIN
    SELECT REF(D1) INTO D1_Ref FROM Departamento D1 WHERE IDDepartamento = 1;
    SELECT REF(D2) INTO D2_Ref FROM Departamento D2 WHERE IDDepartamento = 2;
    INSERT INTO Empresa VALUES (tipoEmpresa(1, "MIDAS", tipoListaDepartamentos(D1_Ref, D2_Ref)));
END;