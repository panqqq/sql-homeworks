CREATE TABLE pay
(
    cardNr    NUMBER(16) PRIMARY KEY,
    salary         NUMBER(8, 2),
    commission_pct NUMBER(2, 2),
    employee_id    NUMBER(6) UNIQUE,
    CONSTRAINT pay_emp_salary_min CHECK (salary > 0)
);

ALTER TABLE PAY
    ADD CONSTRAINT PAY_EMPL_FK FOREIGN KEY (employee_id)
        REFERENCES EMPLOYEES (EMPLOYEE_ID);
