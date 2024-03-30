# Lista de Ejercicios
## Ejercicio 1
Escribe un script PL/SQL anónimo que reciba como entradas:

Un valor real que representa una temperatura.
Un carácter que indica la escala en la que está medida dicha temperatura ('C' para Celsius o 'F' para Farenheit) .

y muestre la temperatura expresada en la otra escala.

Para resolver este ejercicio debes utilizar los siguientes conceptos:

Sentencia IF-THEN-ELSE.
Variables de sustitución (variables que van precedidas del símbolo &) dentro del producto SQL*Plus.
El procedimiento dbms_output.put_line(VARCHAR2 cadena) para mostrar mensajes.

Recuerda que la regla de transformación entre las escalas de temperatura es la siguiente:

Tc=(5/9)*(Tf-32)
Tc=Temperatura en grados Celsius Tf=Temperatura in grados Fahrenheit


Tf=(9/5)*Tc+32
Tc=Temperatura in grados Celsius Tf=Temperatura in grados Fahrenheit 

[Solución](../Ejercicios/ejercicio1.sql).

## Ejercicio 2
Escribe un script PL/SQL anónimo para llevar el control de las ventas de los artículos de la base de datos, siguiendo los siguientes pasos:

- 1.Crea una tabla llamada Inventario donde guardaremos, para cada artículo el número de unidades existentes en el almacén y la fecha en que se actualizó por última vez esa información.

- 2.Crea una tabla denominada ControlVentas donde para cada venta guardaremos el artículo, el número de unidades vendidas o solicitadas, la fecha de venta o solicitud y un comentario que indicará si se pudo satisfacer el pedido o si, por el contrario, no hubo existencias disponibles.

- 3.Introduce algunas filas en las tablas.

- 4.Escribe un script PL/SQL anónimo que procese la orden de compra de cualquier número de unidades de un artículo dado. Si no hay cantidad disponible, se comunicará a través de un mensaje al usuario.

[Solución](../Ejercicios/ejercicio2.sql).

## Ejercicio 3
Escribe un script PL/SQL anónimo para realizar el control de las cuentas bancarias. Para ello, debes crear las siguientes tablas:

Tabla CUENTAS
| Atributo | 	Tipo de Datos |
|----------|------------------|
| IDCuenta |     NUMBER(4)    |
| Valor    |     NUMBER(11,2) |

Tabla ACCIONES
| Atributo   | 	 Tipo de Datos  |
|------------|------------------|
| IDCuenta   |     NUMBER(4)    |
| TipoOp     |     CHAR(1)      |
| NuevoValor |	   NUMBER(11,2) |
| Estado	 |     VARCHAR2(45) |
| FechaMod	 |     DATE         |

El script PL/SQL llevará el control de las cuentas almacenadas en la tabla CUENTAS basándose en las instrucciones almacenadas en la tabla ACCIONES. Cada fila de la tabla ACCIONES contiene:
- El identficador de la cuenta sobre la que se debe actuar (IdCuenta).
- La acción que se debe llevar a cabo codificada con un carácter (TipoOp):
    - i o I para insertar
    - a o A para actualizar
    - b o B para borrar
- Una cantidad que se utilizará en el caso de que se deba actualizar la cuenta a ese valor (NuevoValor).
- Un comentario que indicará el nombre de la operación que se realizó o intentó realizar, seguido de si se realizó o no con éxito (Estado).
- La fecha en la que se actualizó por última vez cada fila de la tabla ACCIONES.

Restricciones de operación:
- Si hay que realizar una inserción y la cuenta ya existe, se realizará una operación de actualización en su lugar.
- Si hay que realizar una actualización de una cuenta que no existe, entonces habrá que realizar una inserción.
- Si hay que borrar una cuenta que no existe, no se realizará ninguna acción.

Como ejemplo, prueba a ejecutar tu script con las siguientes instancias:

Tabla CUENTAS:
| IdCuenta |  Valor  |
|----------|---------|
|    1	   | 1000,00 |
|    2	   | 2000,00 |
|    3	   | 1500,00 |
|    4	   | 6500,00 |
|    5	   | 500,00  |

Tabla ACCIONES:
| IdCuenta | TipoOp  | NuevoValor |	Estado | FechaMod |
|----------|---------|------------|--------|----------|
|    3     |	a	 |    599	  |  null  |   null   |
|    6     |	i	 |   20099	  |  null  |   null   |
|    5     |	B	 |   null	  |  null  |   null   |
|    7     |	A	 |   1599	  |  null  |   null   |
|    1     |	i	 |   399	  |  null  |   null   |
|    9     |	b	 |   null	  |  null  |   null   |
|    10    |	h	 |   null	  |  null  |   null   |

[Solución](../Ejercicios/ejercicio3.sql).

## Ejercicio 4
Dado el esquema que se detalla a continuación, escribe un procedimiento PL/SQL que modifique el precio de los cursos en los que se tengan matriculados en todas sus ediciones un mínimo de n alumnos. El valor de n se recibe como parámetro de entrada y el precio del curso se reduce en el porcentaje indicado en el atributo descuento.
```SQL
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
```
[Solución](../Ejercicios/ejercicio4.sql).

## Ejercicio 5
Escribe una función PL/SQL que devuelva el número de alumnos que hay matriculados en una edición e de un curso c, valores que se reciben como parámetros de entrada.

A continuación, utiliza esta función para escribir una consulta que devuelva para un curso concreto c, su información general y la información de cada edición programada, incluyendo para cada edición el número total de alumnos matriculados en ella.

[Solución](../Ejercicios/ejercicio5.sql).

## Ejercicio 6
Crea un paquete PL/SQL agrupando la función y el procedimiento creados en esta práctica.

Construye un bloque PL/SQL anónimo que realice una llamada a cada uno de los componentes del paquete.

[Solución](../Ejercicios/ejercicio6.sql).

## Ejercicio 7
Escribe un disparador que realice el seguimiento de las operaciones de modificación realizadas sobre la tabla Empleados (CodigoEmpleado, Nombre, Sueldo). El disparador llevará un control de todas las modificaciones que se realicen sobre esta tabla guardando una información común para todas las acciones y otra información específica en el caso de que la modificación proceda de una actualización.

La información común para todas las acciones es:

- Código único generado automáticamente para identificar cada modificación realizada sobre la tabla.
- Nombre del usuario que realiza la modificación.
- Hora en la que se realiza la modificación.
- La acción realizada ("insert", "update" o "delete").
- El valor correspondiente a la clave primaria de la fila modificada. 
- La información específica sólo debe guardarse cuando se produzca una actualización. En este caso, además de la información anterior se deberá almacenar el detalle correspondiente a esta actualización, consistente en: el nombre del atributo modificado, el valor anterior y el valor actual tras la modificación.

Realizar dos implementaciones para generar el código único de cada acción:

a-Utilizando una secuencia. 
b-Utilizando una columna identidad. 

[Solución](../Ejercicios/ejercicio7.sql).

## Ejercicio 8
Pasar el diagrama de clase al lenguaje PL/SQL.
![Diagrama](../img/Captura8.PNG)
[Solución](../Ejercicios/ejercicio8.sql).