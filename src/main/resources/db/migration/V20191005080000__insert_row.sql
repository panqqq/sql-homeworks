INSERT INTO REGIONS VALUES (1, 'EUROPE');

INSERT INTO COUNTRIES VALUES ('MD','Moldova',1);

INSERT INTO LOCATIONS (location_id, street_address, postal_code, city, country_id)
VALUES (5, 'Arborilor 21A','2020','Chisinau','MD');

INSERT INTO departments(department_id, department_name, location_id)
VALUES (22, 'Development', 5);

INSERT INTO JOBS(job_id, job_title)
VALUES(1, 'Java Dev');

INSERT INTO EMPLOYEES (employee_id, first_name, last_name, email, hire_date, job_id, department_id)
VALUES(1, 'John', 'Doe', 'JohnDoe@gmail.com',to_date('2010-05-05','YYYY-MM-DD'), 1, 22);

INSERT INTO job_history
VALUES (1, to_date('2010-05-05','YYYY-MM-DD'), to_date('2015-05-05','YYYY-MM-DD'), 1, 22);