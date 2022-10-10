ALTER TABLE locations
ADD department_amount NUMBER(6) DEFAULT 0;

COMMENT ON COLUMN locations.department_amount IS 'Contains the amount of departments in the location.';

create or replace TRIGGER trg_locations_department_amount
BEFORE INSERT OR DELETE
ON departments
FOR EACH ROW
BEGIN
IF INSERTING THEN
    UPDATE locations l SET l.department_amount = l.department_amount + 1 WHERE l.location_id = :NEW.location_id;
  ELSIF DELETING THEN
    UPDATE locations l SET l.department_amount = l.department_amount - 1 WHERE l.location_id = :OLD.location_id;
  END IF;
END;