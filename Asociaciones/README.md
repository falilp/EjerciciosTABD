# Asociaciones
Hay varios tipos de asociaciones que se pueden establecer en una base de datos relacional:
- Relación Uno a Uno (1:1)
- Relación Uno a Muchos (1:N)
- Relación Muchos a Muchos (M:N)

## Relación Uno a Uno (1:1) 
En esta asociación, un registro en una tabla está asociado con exactamente un registro en otra tabla, y viceversa. Por ejemplo, una tabla de "personas" podría estar relacionada con una tabla de "pasaportes", donde cada persona tiene un único pasaporte.

![Diagrama](../img/Captura2.PNG)
[Ejemplo de Asociaciones Uno a Uno](../Asociaciones/asociacion1a1.sql).

## Relación Uno a Muchos (1:N)
En esta asociación, un registro en una tabla puede estar asociado con uno o más registros en otra tabla, pero un registro en la segunda tabla solo está asociado con un registro en la primera tabla. Por ejemplo, una tabla de "departamentos" puede estar relacionada con una tabla de "empleados", donde un departamento puede tener muchos empleados, pero un empleado solo puede pertenecer a un departamento.

![Diagrama](../img/Captura3.PNG)
[Ejemplo de Asociaciones Uno a Muchos](../Asociaciones/asociacion1aN.sql).

## Relación Muchos a Muchos (M:N)
En este tipo de asociación, múltiples registros en una tabla pueden estar asociados con múltiples registros en otra tabla. Esto se logra mediante una tercera tabla, llamada tabla de unión o tabla puente, que mapea las relaciones entre las dos tablas principales. Por ejemplo, en una base de datos de una librería, podría haber una tabla de "libros" y una tabla de "autores", y una tercera tabla "libros_autores" que mapea qué autores escribieron qué libros.

![Diagrama](../img/Captura4.PNG)
[Ejemplo de Asociaciones Uno a Muchos](../Asociaciones/asociacionNaN.sql).

## Ejemplo de inserción en asociaciones 1:N
```sql
INSERT INTO Persona VALUES (tipoPersona(1, "Francisco García", ….));
INSERT INTO Persona VALUES (tipoPersona(2,"Luisa Pérez", …));

DECLARE -- Bloque PL/SQL para insertar un proyecto donde trabajan estas dos personas

Ref_Persona1 REF tipoPersona;
Ref_Persona2 REF tipoPersona;

BEGIN
    SELECT REF(Persona1) INTO Ref_Persona1 FROM Persona Persona1 WHERE IDPersona=1;
    SELECT REF(Persona2) INTO Ref_Persona2 FROM Persona Persona2 WHERE IDPersona=2;
    INSERT INTO Proyecto
    VALUES (tipoProyecto(1,300000.00,Tipo_Participantes(Ref_Persona1, Ref_Persona2)));
END;

DECLARE -- Bloque PL/SQL para actualizar la referencia a este proyecto en la tabla Personas

Ref_Proyecto1 REF tipoProyecto;

BEGIN
    SELECT REF(Proyecto1) INTO Ref_Proyecto1 FROM Proyecto Proyecto1
    WHERE IDProyecto=1;
    UPDATE Persona SET Desarrolla= Ref_Proyecto1 WHERE IDPersona IN (1,2);
END;
```