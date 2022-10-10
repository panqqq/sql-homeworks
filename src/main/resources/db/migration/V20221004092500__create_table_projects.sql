CREATE TABLE projects
(
    project_id    NUMBER(6) PRIMARY KEY,
    project_description VARCHAR(250),
    project_investments NUMBER(6, -3),
    project_revenue NUMBER(6),

    CONSTRAINT projects_description_min_length CHECK (LENGTH(project_description) > 10),
    CONSTRAINT projects_project_investments_greater_than_zero CHECK (project_investments >= 0)
);

CREATE SEQUENCE projects_seq NOCACHE;

ALTER TABLE projects
    MODIFY project_id DEFAULT projects_seq.nextval;