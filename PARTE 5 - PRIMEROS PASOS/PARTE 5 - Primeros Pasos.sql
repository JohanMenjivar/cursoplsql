SET SERVEROUTPUT on
BEGIN
DBMS_OUTPUT.PUT_LINE('JOHAN ANTHONY MENJVIAR GIRON');
END;

-- BLOQUES ANONIMOS Y VARIABLES
--2-Crear dos variables de tipo numérico y visualizar su suma
DECLARE
x integer:=2;
y integer:=2;
BEGIN
DBMS_OUTPUT.PUT_LINE(x+y);
END;

--3-Modificar el ejemplo anterior y ponemos null como valor de una de las variables. ¿Qué resultado arroja? Volvemos a ponerla un valor numérico
DECLARE
x integer:=2;
y integer:=null;
BEGIN
DBMS_OUTPUT.PUT_LINE(x+y);
END;

--4-Añadir una constante al ejercicio. Sumamos las 2 variables y la constantes. Intentar modificar la constante. ¿Es posible?
DECLARE
x integer:=2;
y integer:=2;
z constant integer:=1000;
BEGIN
DBMS_OUTPUT.PUT_LINE(x+y+z);
END;

/*5-Crear un bloque anónimo que tenga una variable de tipo VARCHAR2 con
nuestro nombre, otra numérica con la edad y una tercera con la fecha de
nacimiento. Visualizarlas por separado y luego intentar concatenarlas. ¿es
posible?*/
DECLARE
NOMBRE VARCHAR2(200):='Johan';
nacimiento DATE:='11/09/2000';
edad number:=23 ;
BEGIN
DBMS_OUTPUT.PUT_LINE(NOMBRE || ' ' || edad || ' ' || nacimiento);
END;


--Práctica adicional Variables y Constantes
/*Queremos calcular el impuesto de un producto
o El impuesto será del 21%. Le debemos poner en una constante
o Creamos una variable de tipo number (5,2) para poner el precio del
producto
o Creamos otra variable para el resultado. Le decimos que es del
mismo tipo (type) que la anterior
o Hacemos el cálculo y visualizamos el resultado.*/

DECLARE
porcentajeImpuesto constant number(3,2):=0.21;
precio number(5,2):=99.99;
precioNeto precio%TYPE:=precio *(1+porcentajeImpuesto);
BEGIN
DBMS_OUTPUT.PUT_LINE('Precio neto: $' ||  precioNeto);
END;


-- FUNCIONES
DECLARE
NOMBRE VARCHAR2(200):='Johan';
APELLIDO1 VARCHAR2(200):='Menjivar';
APELLIDO2 VARCHAR2(200):='giron';
BEGIN
DBMS_OUTPUT.PUT_LINE(SUBSTR(UPPER(NOMBRE),1,1) || '.' ||SUBSTR(UPPER(APELLIDO1),1,1) || '.' || SUBSTR(UPPER(APELLIDO2),1,1));
END;

DECLARE
Nacimiento DATE:='11/09/2000';
BEGIN
DBMS_OUTPUT.PUT_LINE(TO_CHAR(Nacimiento, 'DAY'));
END;