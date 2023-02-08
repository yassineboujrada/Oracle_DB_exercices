--variable g_salary NUMBER
--SET SERVEROUT ON;
DECLARE g1_salary NUMBER;
BEGIN 
    SELECT salary 
    INTO g1_salary
    FROM employees
    WHERE employee_id=101;
    DBMS_OUTPUT.put_line(g1_salary);
END;
--/
--PRINT g_salary

Define p_annuel_sal=600000
declare
    v_sal number(9,2):= &p_annuel_sal;
BEGIN 
    v_sal := v_sal/12;
    DBMS_OUTPUT.put_line('salaire : '|| to_char(v_sal));
    
End;

<<outer>>
DECLARE
    v_sal number(7,2) := 60000;
    v_comm number(7,2) := v_sal*0.20;
    v_mssg varchar2(255) := 'aligible for commission';
BEGIN
    DECLARE
        v_sal number(7,2) := 60000;
        v_comm number(7,2) := 0;
        v_total_comp number(7,2) := v_sal+v_comm;
    BEGIN 
        v_mssg := 'clerk not'||v_mssg;
        outer.v_comm:= v_sal*0.30;
    END;
    v_mssg:= 'SALESMAN'||v_mssg;
    DBMS_OUTPUT.put_line(v_mssg);
END;

declare 
    v_sum_sal number(10,2);
    v_deptno number not null :=60;
BEGIN
    select sum(salary)
    into v_sum_sal
    from employees
    where departement_id = v_deptno;
    DBMS_OUTPUT.put_line(v_sum_sal);
--EXCEPTION ();
End;

variable rows_deleted VARCHAR2(30)
declare
    v_employee_id employees.employee_id%TYPE:=205;
begin 
    delete from employees 
    where employee_id =v_employee_id;
    :rows_deleted:= (SQL%ROWCOUNT||'row deleted');
    DBMS_OUTPUT.put_line(:rows_deleted);
end;

declare
    v_country_id location.country_id%type:='US';
    v_location_id location.location_id%type;
    v_counter number(2) :=1;
    v_city location.city%type := 'Montreal';
begin
    select max(location_id) into v_location_id from location where country_id = v_country_id;
    loop
        insert into location(location_id,city,country_id) values((v_location_id+v_counter),v_city,v_country_id);
        v_counter:=v_counter+1;
        exit when v_counter>3 ;
    end loop;
end;

declare
    v_country_id location.country_id%type:='UK';
    v_location_id location.location_id%type;
    v_counter number(2) :=1;
    v_city location.city%type := 'Montreal';
begin
    select max(location_id) into v_location_id from location where country_id = v_country_id;
    while v_counter<=3 loop
        insert into location(location_id,city,country_id) values((v_location_id+v_counter),v_city,v_country_id);
        v_counter:=v_counter+1;
    end loop;
end;

declare
    v_country_id location.country_id%type:='UK';
    v_location_id location.location_id%type;
    v_city location.city%type := 'Montreal';
begin
    select max(location_id) into v_location_id from location where country_id = v_country_id;
    for i in 1..3 loop
        insert into location(location_id,city,country_id) values((v_location_id+i),v_city,v_country_id);
    end loop;
end;

declare 
    v_empno employees.employee_id%TYPE;
    v_ename employees.last_name%TYPE;
    CURSOR emp_curs is select employee_id,last_name from employees;
BEGIN
    open emp_curs;
    loop
        fetch emp_curs into v_empno,v_ename;
        exit when emp_curs%ROWCOUNT >10 or emp_curs%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(v_empno||''||v_ename);
    end loop;
    close emp_curs;
end;

declare 
    CURSOR emp_curs is select last_name,departement_id from employees;
BEGIN
    for emp_record in emp_curs loop
        if emp_record.departement_id =80 then
            DBMS_OUTPUT.PUT_LINE(emp_record);
        end if;
    end loop;
end;

BEGIN
    for emp_record in (select last_name,departement_id from employees) loop
        if emp_record.departement_id =80 then
            DBMS_OUTPUT.PUT_LINE(emp_record);
        end if;
    end loop;
end;

--declare 
--    CURSOR emp_curs is select employee_id,last_name from employees;
--    emp_record emp_curs%ROWTYPE;
--BEGIN
--    open emp_curs;
--    loop
--        fetch emp_curs into v_empno,v_ename;
--        exit when emp_curs%ROWCOUNT >10 or emp_curs%NOTFOUND;
--        DBMS_OUTPUT.PUT_LINE(v_empno||''||v_ename);
--    end loop;
--    close emp_curs;
--end;