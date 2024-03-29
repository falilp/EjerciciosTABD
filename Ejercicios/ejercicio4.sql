CREATE TABLE Cursos (
    Cod_Curso NUMBER(5),
    Nombre VARCHAR2(50) NOT NULL,
    Descripcion VARCHAR2(90) NOT NULL,
    Precio NUMBER(5,2) NOT NULL,
    Descuento NUMBER(4,2) NOT NULL,
    CONSTRAINT PK_Cursos PRIMARY KEY (Cod_Curso)
);

CREATE TABLE Alumnos ( 
    Cod_Alumno NUMBER(5),
    Nombre VARCHAR2(50) NOT NULL,
    Apellidos VARCHAR2(50) NOT NULL,
    CONSTRAINT PK_Alumnos PRIMARY KEY (Cod_Alumno)
);

CREATE TABLE Edicion (
    Cod_Curso NUMBER(5),
    Cod_Edicion NUMBER(3),
    Fecha_Inicio DATE NOT NULL,
    Fecha_Fin DATE NOT NULL,
    Lugar VARCHAR2(40) NOT NULL,
    CONSTRAINT PK_Edicion PRIMARY KEY (Cod_Curso, Cod_Edicion),
    CONSTRAINT FK_Edicion_Cursos FOREIGN KEY (Cod_Curso) REFERENCES Cursos(Cod_Curso)
);

CREATE TABLE Matricula (
    Cod_Curso NUMBER(5),
    Cod_Edicion NUMBER(2),
    Cod_Alumno NUMBER(5),
    Fecha_Matricula DATE NOT NULL,
    CONSTRAINT PK_Matricula PRIMARY KEY (Cod_Curso, Cod_Edicion, Cod_Alumno),
    CONSTRAINT FK_Matricula_Edicion FOREIGN KEY (Cod_Curso, Cod_Edicion) REFERENCES Edicion(Cod_Curso, Cod_Edicion),
    CONSTRAINT FK_Matricula_Alumnos FOREIGN KEY (Cod_Alumno) REFERENCES Alumnos(Cod_Alumno)
); 

SET SERVEROUTPUT ON
CREATE OR REPLACE PROCEDURE modificarPrecioCurso(
    minimoAlumnos IN NUMBER
)
AS
    v_porcentajeDescuento Cursos.Descuento%TYPE;
    v_codigoCurso Cursos.Cod_Curso%TYPE;
    v_preciOriginal Cursos.Precio%TYPE;
BEGIN
    FOR curso IN (SELECT c.Cod_Curso, c.Descuento FROM Cursos c WHERE EXISTS
        (SELECT 1 FROM Edicion e WHERE c.Cod_Curso = e.Cod_Curso GROUP BY e.Cod_Curso HAVING COUNT(*) >= minimoAlumnos)) LOOP

        v_codigoCurso := c.Cod_Curso;
        v_porcentajeDescuento := c.Descuento;

        SELECT Precio INTO v_preciOriginal FROM Cursos WHERE Cod_Curso = v_codigoCurso;
        UPDATE Cursos SET Precio = v_preciOriginal * (1-v_porcentajeDescuento/100) WHERE Cod_Curso = v_codigoCurso;

        DBMS_OUTPUT.PUT_LINE('Se ha modificado correctamente el precio del curso')
    END LOOP;
    COMMIT;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No se encontraron cursos con un mínimo de ' || minimoAlumnos || ' alumnos matriculados.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;