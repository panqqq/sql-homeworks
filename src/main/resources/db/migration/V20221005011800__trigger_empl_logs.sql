create or replace TRIGGER trg_employment_logs
AFTER INSERT OR DELETE
ON employees
FOR EACH ROW
DECLARE
status varchar(5);
f_name varchar(30);
l_name varchar(30);
BEGIN
    IF INSERTING THEN
        status := 'HIRED';
        f_name := :NEW.first_name;
        l_name := :NEW.last_name;
    ELSIF DELETING THEN
        status := 'FIRED';
        f_name := :OLD.first_name;
        l_name := :OLD.last_name;
    END IF;

  EXEC EMPLOYMENT_LOG_MOVE(f_name, l_name, status);
  --INSERT INTO employment_logs(first_name, last_name, employment_action) VALUES (f_name, l_name, status);
END;
/