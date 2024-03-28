# Estructuras
En esta sección veremos ROWS, UDT`s, Referencias y colecciones.

## Row types
Tipo de datos para representar atributos de tipo fila en la definición de las tablas.
[Ejemplo de ROW](/EjerciciosTABD/Estructuras/row.sql).

## UDT's (User Defined Types)
Definición de clases tanto estructura y métodos.
- Tipo de un atributo en una relación => column type
- Tipo de las filas de una relación => rowtype

[Ejemplo de UDT](/EjerciciosTABD/Estructuras/udt.sql).

Puede utilizarse los UDT's tanto para la definición de un tipo para un atributo de una relación y definición de un tipo para un atributo de otro UDT.

Un UDT también puede proporcionar el esquema de una tabla. 

## Referencias
Son punteros a los tipos de datos, si X es un UDT entonces la REF de X es un puntero a un objeto de tipo X.

[Ejemplo de REF](/EjerciciosTABD/Estructuras/ref.sql).

## Colecciones
- ARRAYS: Permiten almacenar colecciones de valores directamente en una columna de una tabla
- SETS: Permiten almacenar colecciones de valores directamente en un conjunto. Un conjunto se trata igual que una tabla, excepto la restricción de valor único para sus elementos.
- LISTS: Permiten almacenar colecciones de valores directamente en una lista sobre la que existe una relación de orden. Una lista se trata básicamente igual que una tabla, pero hay operadores especiales (element, position).

[Ejemplo de colecciones](/EjerciciosTABD/Estructuras/colecciones.sql).