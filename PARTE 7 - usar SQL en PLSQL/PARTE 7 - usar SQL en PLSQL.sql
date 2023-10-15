-- sql en pl sql
/*Práctica SELECT INTO
Realiza los siguientes ejemplos. Usa %ROWTYPE y %TYPE
1. PRÁCTICA 1
• Crear un bloque PL/SQL que devuelva al salario máximo del
departamento 100 y lo deje en una variable denominada salario_maximo
y la visualice
2. PRÁCTICA2
• Visualizar el tipo de trabajo del empleado número 100
3. PRÁCTICA 3
• Crear una variable de tipo DEPARTMENT_ID y ponerla algún valor, por
ejemplo 10.
• Visualizar el nombre de ese departamento y el número de empleados
que tiene, poniendo. Crear dos variables para albergar los valores.
4. PRÁCTICA 4
• Mediante dos consultas recuperar el salario máximo y el salario mínimo
de la empresa e indicar su diferencia*/
/*************************SELECT*********************/
DECLARE
SALARIO NUMBER(20):=0;
BEGIN
     SELECT max(salary) INTO SALARIO from employees;
    dbms_output.put_line(SALARIO);
END;

DECLARE
TRABAJO VARCHAR(20);
BEGIN
     SELECT job_id INTO TRABAJO from employees WHERE EMPLOYEE_ID=100;
    dbms_output.put_line(TRABAJO);
END;

DECLARE
deptName varchar(20):='';
numeroEmpleados  number(35):='';
numeroDepartamentoABuscar departments.department_id%TYPE:=10;
BEGIN
     SELECT department_name INTO deptName from departments WHERE department_id=numeroDepartamentoABuscar;
     SELECT COUNT(*) INTO numeroEmpleados from employees where department_id=numeroDepartamentoABuscar;
    dbms_output.put_line(deptName|| ', ' ||numeroEmpleados);
END;

DECLARE
SALARIOMAX EMPLOYEES.SALARY%TYPE;
SALARIOMIN EMPLOYEES.SALARY%TYPE;
BEGIN
     SELECT max(salary) INTO SALARIOMAX from employees;
     SELECT MIN(salary) INTO SALARIOMIN from employees;
    dbms_output.put_line(SALARIOMAX || ' - ' ||SALARIOMIN || ' = '|| (SALARIOMAX-SALARIOMIN));
END;


/*Práctica INSERT, UPDATE, DELETE 
1-	Crear un bloque que inserte un nuevo departamento en la tabla DEPARTMENTS. Para saber el DEPARTMENT_ID que debemos asignar al nuevo departamento primero debemos averiguar el valor mayor que hay en la tabla DEPARTMENTS y sumarle uno para la nueva clave. 
• Location_id debe ser 1000 
• Manager_id debe ser 100 
• Department_name debe ser “INFORMATICA” 
• NOTA: en PL/SQL debemos usar COMMIT y ROLLBACK de la misma forma que lo hacemos en SQL. Por tanto, para validar definitivamente un cambio debemos usar COMMIT.
*/
DECLARE
maxValueOfDepartmentId departments.department_id%type;
BEGIN
     select max(department_id) into maxValueOfDepartmentId from departments;
     insert into departments values(maxValueOfDepartmentId+1, 'INFORMATICA',100,1000);
     COMMIT;
END;

BEGIN
   UPDATE departments
   SET location_id = 1700
   WHERE department_id = (271);
   COMMIT;
END;

BEGIN
   delete from departments
   WHERE department_id = (271);
   COMMIT;
END;

delete from departments where department_id = 271;
select * from departments;