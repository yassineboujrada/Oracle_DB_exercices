set SERVEROUT on;

select first_name,last_name, email from EMPLOYEES;

CREATE table account_employees (
        username varchar2(20),
        email varchar2(100),
        password varchar2(10)
);
    
declare 
    cursor employees_data is select first_name , last_name, email from EMPLOYEES;
    v_first_name EMPLOYEES.first_name%type;
    v_last_name EMPLOYEES.last_name%type;
    v_email EMPLOYEES.email%type;
    OTHERS EXCEPTION;
begin
    open employees_data;
    loop 
        fetch employees_data into v_first_name,v_last_name,v_email;
        exit when employees_data%notfound;
        INSERT into account_employees values(v_first_name,v_email||'@gmail.com',substr(v_first_name,1,3)||substr(v_last_name,1,3));
    end loop;
    close employees_data;
end;