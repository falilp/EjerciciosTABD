CREATE TYPE tipoEmpleado AS(
    PUBLIC 
        nombre VARCHAR2(32),
        direccion TipoDireccion,
        jefe REF tipoEmpleado,
    PRIVATE 
        sueldoBase DECIMAL(7,2),
        comision DECIMAL(7,2),
    PUBLIC 
        MEMBER FUNCTION sueldo(tipoEmpleado IN empleado) RETURNS DECIMAL
);