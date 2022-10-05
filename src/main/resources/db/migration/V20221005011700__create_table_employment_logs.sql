CREATE TABLE employment_logs
(
    employment_log_id    NUMBER(6) PRIMARY KEY,
    first_name     VARCHAR2(20),
    last_name      VARCHAR2(25)        NOT NULL,
    employment_action       VARCHAR2(5) NOT NULL,
    employment_status_updtd_tmstmp      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT emp_logs_action CHECK (employment_action = 'HIRED' OR employment_action = 'FIRED')
);

CREATE SEQUENCE employment_logs_seq NOCACHE;

ALTER TABLE employment_logs
    MODIFY employment_log_id DEFAULT employment_logs_seq.nextval;

CREATE OR REPLACE PROCEDURE employment_log_move
(f_name IN varchar,
l_name IN varchar,
e_action IN varchar)
AS
BEGIN
INSERT INTO employment_logs(first_name, last_name, employment_action) VALUES (f_name, l_name, e_action);
END employment_log_move;
/
--EXEC employment_log_move ('John','Doe','HIRED');