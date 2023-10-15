/*Práctica de TRIGGERS
1. Crear un TRIGGER BEFORE DELETE sobre la tabla EMPLOYEES que
impida borrar un registro si su JOB_ID es algo relacionado con CLERK
2. Crear una tabla denominada AUDITORIA con las siguientes columnas:
CREATE TABLE AUDITORIA (
USUARIO VARCHAR(50),
FECHA DATE, 
SALARIO_ANTIGUO NUMBER,
SALARIO_NUEVO NUMBER);
3. Crear un TRIGGER BEFORE INSERT de tipo STATEMENT, de forma que
cada vez que se haga un INSERT en la tabla REGIONS guarde una fila
en la tabla AUDITORIA con el usuario y la fecha en la que se ha hecho el
INSERT
4. Realizar otro trigger BEFORE UPDATE de la columna SALARY de tipo
EACH ROW.
• Si la modificación supone rebajar el salario el TRIGGER debe
disparar un RAISE_APPLICATION_FAILURE “no se puede bajar
un salario”.
• Si el salario es mayor debemos dejar el salario antiguo y el salario
nuevo en la tabla AUDITORIA.
5. Crear un TRIGGER BEFORE INSERT en la tabla DEPARTMENTS que al
insertar un departamento compruebe que el código no esté repetido y
luego que si el LOCATION_ID es NULL le ponga 1700 y si el
MANAGER_ID es NULL le ponga 200*/

create or replace trigger impedirBorrarClerk before 
delete on employees FOR EACH ROW
begin
if :old.job_id like('%CLERK%') then
raise_application_error(-20001, 'No se pueden eliminar empleados de tipo CLERK');
end if;
end;


select* from employees;
delete from employees where job_id like('%CLERK'); 


CREATE TABLE AUDITORIA (
USUARIO VARCHAR(50),
FECHA DATE,
SALARIO_ANTIGUO NUMBER,
SALARIO_NUEVO NUMBER);

create or replace trigger insertarEnAuditoria after insert ON regions 
BEGIN
insert into auditoria values(USER,SYSDATE,0,0);
END;

INSERT INTO REGIONS VALUES(8,'TURKMENISTAN');
SELECT * FROM AUDITORIA;

create or replace trigger insertarEnAuditoriaCambioSalario BEFORE UPDATE ON EMPLOYEES for each row
BEGIN 
IF :old.salary>:new.salary then
    raise_application_error(-20011, 'no se puede bajar un salario.');
elsif :old.salary<:new.salary then
    insert into auditoria values(USER,SYSDATE,:old.salary,:new.salary);
end if;
END;

update employees set salary=25000 where employee_id=100;

update employees set salary=24000 where employee_id=100;
select * from employees;

create or replace trigger chekearNulosEnDepartamentos before insert on departments for each row
declare
dept_count NUMBER;
    begin
    SELECT COUNT(*) INTO dept_count
    FROM DEPARTMENTS
    WHERE DEPARTMENT_ID = :new.DEPARTMENT_ID;
    IF dept_count > 0 THEN
        raise_application_error(-20069, 'El código de departamento ya está en uso');
    end if;
    
    IF :new.location_id IS NULL THEN
        :new.location_id := 1700;
    END IF;


    IF :new.manager_id IS NULL THEN
        :new.manager_id := 200;
    END IF;

end;

insert into departments (department_id,department_name) values('210','Departamento de futbol siuuu');
select * from departments;
