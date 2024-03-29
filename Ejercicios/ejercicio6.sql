CREATE OR REPLACE PACKAGE cursoPackage AS
    FUNCTION numeroAlumnos(c IN NUMBER, e IN NUMBER)RETURN NUMBER;
    PROCEDURE modificarPrecioCurso(minimoAlumnos IN NUMBER);
END cursoPackage;

CREATE OR REPLACE PACKAGE BODY cursoPackage AS
    FUNCTION numeroAlumnos(c IN NUMBER, e IN NUMBER)RETURN NUMBER
    AS
        v_numeroAlumnos NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_numeroAlumnos FROM Matricula WHERE Cod_Curso = c AND Cod_Edicion = e;
        RETURN v_numeroAlumnos;

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN 0;
        WHEN OTHERS THEN
            RAISE;
    END numeroAlumnos;

    PROCEDURE modificarPrecioCurso(minimoAlumnos IN NUMBER)
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
    END modificarPrecioCurso;
END cursoPackage;

SET SERVEROUTPUT ON;
DECLARE
    v_curso NUMBER := 1;
    v_edicion NUMBER := 2;
    v_minimoAlumnos NUMBER := 15;
    v_numeroAlumnos NUMBER;
BEGIN
    v_numeroAlumnos := cursoPackage.numeroAlumnos(v_curso,v_edicion);
    DBMS_OUTPUT.PUT_LINE('El resultado del numero de alumnos matriculados en la edicion ' || v_edicion || " del curso " || v_curso || " es de " || v_numeroAlumnos || " alumnos.");

    cursoPackage.modificarPrecioCurso(v_minimoAlumnos);
END;