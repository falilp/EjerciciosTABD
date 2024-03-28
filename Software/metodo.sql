CREATE TYPE tipoProducto AS(
    nombre VARCHAR2(32),
    costeUnidad NUMBER

    MEMBER FUNCTION costeTotal(cantidad IN NUMBER) RETURNS NUMBER,
    PRAGMA RESTRICT_REFERENCES(cantidad, WNDS)
);

CREATE TYPE BODY tipoProducto AS
MEMBER FUNCTION
costeTotal(cantidad NUMBER) RETURNS NUMBER IS
    BEGIN
        RETURN cantidad*SELF.costeUnidad;
    END;
END;