CREATE TABLE employees_projects
(
    employees_projects_id    NUMBER(6) PRIMARY KEY,
    employee_id   NUMBER(6),
    project_id    NUMBER(6),
    worked_hours NUMBER(6)
);

CREATE SEQUENCE employees_projects_seq NOCACHE;

ALTER TABLE employees_projects
    MODIFY employees_projects_id DEFAULT employees_projects_seq.nextval;

ALTER TABLE employees_projects
    ADD CONSTRAINT employees_projects_empl_id_FK FOREIGN KEY (employee_id)
        REFERENCES EMPLOYEES (EMPLOYEE_ID);

ALTER TABLE employees_projects
    ADD CONSTRAINT employees_projects_project_id_FK FOREIGN KEY (project_id)
        REFERENCES PROJECTS (PROJECT_ID);

