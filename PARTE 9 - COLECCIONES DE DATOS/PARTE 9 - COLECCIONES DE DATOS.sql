SET SERVEROUTPUT ON;

/*Práctica de COLECCIONES y RECORDS
• Creamos un TYPE RECORD que tenga las siguientes columnas
NAME VARCHAR2(100),
SAL EMPLOYEES.SALARY%TYPE,
COD_DEPT EMPLOYEES.DEPARTMENT_ID%TYPE);
• Creamos un TYPE TABLE basado en el RECORD anterior
• Mediante un bucle cargamos en la colección los empleados. El campo NAME
debe contener FIRST_NAME y LAST_NAME concatenado.
• Para cargar las filas y siguiendo un ejemplo parecido que hemos visto en el
vídeo usamos el EMPLOYEE_ID que va de 100 a 206
• A partir de este momento y ya con la colección cargada, hacemos las siguientes
operaciones, usando métodos de la colección.
• Visualizamos toda la colección
• Visualizamos el primer empleado
• Visualizamos el último empleado
• Visualizamos el número de empleados
• Borramos los empleados que ganan menos de 7000 y visualizamos de
nuevo la colección
• Volvemos a visualizar el número de empleados para ver cuantos se han
borrado*/

DECLARE
i integer:=0;
fin integer:=0;
TYPE empleado is record(
    name varchar2(200),
    sal employees.salary%type,
    cod_dept employees.department_id%type
);

TYPE empleados is table of empleado INDEX BY PLS_INTEGER;
misEmpleados empleados;
BEGIN
SELECT COUNT(*) INTO fin from employees where employee_id between 100 and 206;
for i in 1..fin loop
      SELECT first_name||' '||last_name, salary, department_id
      INTO misEmpleados(i).name, misEmpleados(i).sal, misEmpleados(i).cod_dept
      FROM employees
      WHERE employee_id = i+99;
end loop;
FOR i IN misEmpleados.FIRST..misEmpleados.LAST LOOP
if misEmpleados.exists(i) then
    DBMS_OUTPUT.PUT_LINE('Nombre: ' || misEmpleados(i).name);
    DBMS_OUTPUT.PUT_LINE('Salario: ' || misEmpleados(i).sal);
    DBMS_OUTPUT.PUT_LINE('Código de Departamento: ' || misEmpleados(i).cod_dept);
     DBMS_OUTPUT.PUT_LINE('');
end if;
END LOOP;
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('PRIMER EMPLEADO:');
    DBMS_OUTPUT.PUT_LINE('Nombre: ' || misEmpleados(misEmpleados.FIRST).name);
    DBMS_OUTPUT.PUT_LINE('Salario: ' || misEmpleados(misEmpleados.FIRST).sal);
    DBMS_OUTPUT.PUT_LINE('Código de Departamento: ' || misEmpleados(misEmpleados.FIRST).cod_dept);
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('ULTIMO EMPLEADO:');
    DBMS_OUTPUT.PUT_LINE('Nombre: ' || misEmpleados(misEmpleados.LAST).name);
    DBMS_OUTPUT.PUT_LINE('Salario: ' || misEmpleados(misEmpleados.LAST).sal);
    DBMS_OUTPUT.PUT_LINE('Código de Departamento: ' || misEmpleados(misEmpleados.LAST).cod_dept);
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('NUMERO DE EMPLEADOS: ' || misEmpleados.COUNT );
    
FOR i IN misEmpleados.FIRST..misEmpleados.LAST LOOP
    IF misEmpleados(i).sal<7000 THEN
    misEmpleados.DELETE(i);
    END IF;
END LOOP;

FOR i IN misEmpleados.FIRST..misEmpleados.LAST LOOP
if misEmpleados.exists(i) then
    DBMS_OUTPUT.PUT_LINE('Nombre: ' || misEmpleados(i).name);
    DBMS_OUTPUT.PUT_LINE('Salario: ' || misEmpleados(i).sal);
    DBMS_OUTPUT.PUT_LINE('Código de Departamento: ' || misEmpleados(i).cod_dept);
     DBMS_OUTPUT.PUT_LINE('');
end if;
END LOOP;
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('NUMERO DE EMPLEADOS: ' || misEmpleados.COUNT );
    
END;


select *  from employees