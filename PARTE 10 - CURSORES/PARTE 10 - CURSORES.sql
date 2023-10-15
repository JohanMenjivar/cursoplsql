SET SERVEROUTPUT ON

/*1. PRÁCTICAS CON CURSORES
• 1-Hacer un programa que tenga un cursor que vaya visualizando los salarios de
los empleados. Si en el cursor aparece el jefe (Steven King) se debe generar un
RAISE_APPLICATION_ERROR indicando que el sueldo del jefe no se puede
ver.
• 2- Vamos averiguar cuales son los JEFES (MANAGER_ID) de cada
departamento. En la tabla DEPARTMENTS figura el MANAGER_ID de cada
departamento, que a su vez es también un empleado. Hacemos un bloque con
dos cursores. (Esto se puede hacer fácilmente con una sola SELECT pero vamos
a hacerlo de esta manera para probar parámetros en cursores).
o El primero de todos los empleados
o El segundo de departamentos, buscando el MANAGER_ID con el
parámetro que se le pasa.
o Por cada fila del primero, abrimos el segundo cursor pasando el
EMPLOYEE_ID
o Si el empleado es MANAGER_ID en algún departamento debemos
pintar el Nombre del departamento y el nombre del MANAGER_ID
diciendo que es el jefe.
o Si el empleado no es MANAGER de ningún departamento debemos
poner “No es jefe de nada”
• 3-Crear un cursor con parámetros que pasando el número de departamento
visualice el número de empleados de ese departamento
• 4-Crear un bucle FOR donde declaramos una subconsulta que nos devuelva el
nombre de los empleados que sean ST_CLERCK. Es decir, no declaramos el
cursor sino que lo indicamos directamente en el FOR.
• 5-Creamos un bloque que tenga un cursor para empleados. Debemos crearlo con
FOR UPDATE.
o Por cada fila recuperada, si el salario es mayor de 8000 incrementamos el
salario un 2%
o Si es menor de 800 lo hacemos en un 3%
o Debemos modificarlo con la cláusula CURRENT OF
o Comprobar que los salarios se han modificado correctamente.*/

DECLARE
CURSOR empleado is select * from employees;
salarioDelJefe exception;
BEGIN
for empleados in empleado loop
if empleados.employee_id=100 THEN
RAISE salarioDelJefe;
END IF;
end loop;
EXCEPTION
WHEN salarioDelJefe THEN
RAISE_APPLICATION_ERROR(-20069,'El salario del jefe no puede ser visto');
END;

DECLARE
CURSOR empleado is select * from employees;
CURSOR saberJefesDeDepartamentos(id_empleado employees.employee_id%type) is select * from departments where id_empleado=manager_id;
departamento departments%ROWTYPE;
BEGIN
for empleados in empleado loop
OPEN saberJefesDeDepartamentos(empleados.employee_id);
FETCH saberJefesDeDepartamentos INTO departamento;
if saberJefesDeDepartamentos%FOUND THEN

        DBMS_OUTPUT.PUT_LINE('Nombre: ' || empleados.first_name);
        DBMS_OUTPUT.PUT_LINE('Departamento bajo su mando: ' || departamento.department_name);
        DBMS_OUTPUT.PUT_LINE('');
END IF;
CLOSE saberJefesDeDepartamentos;
end loop;
END;

DECLARE
numeroEmpleados number:=0;
CURSOR saberNumeroDeEmpleados(numeroDepartamento departments.department_id%TYPE) IS 
select count(*) from employees where department_id=numeroDepartamento;
BEGIN
open saberNumeroDeEmpleados(60);
    fetch saberNumeroDeEmpleados into numeroEmpleados;
    DBMS_OUTPUT.PUT_LINE(numeroEmpleados);
close saberNumeroDeEmpleados;
END;


BEGIN
for empleados in (select*from employees where job_id='ST_CLERK') LOOP
    DBMS_OUTPUT.PUT_LINE(empleados.first_name);
END LOOP;
END;

DECLARE
CURSOR empleados is select * from employees for update;
BEGIN
for empleado in empleados loop
    if empleado.salary>8000 then
        update employees set salary = salary*1.02 where current of empleados;
    elsif empleado.salary<8000 then
    update employees set salary = salary*1.03 where current of empleados;
    end if;
end loop;
end;

select * from employees;
rollback;