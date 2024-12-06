DROP TABLE IF EXISTS Event;
CREATE TABLE Event (
    discipline VARCHAR(50)   NOT NULL,
    event VARCHAR(50)      NOT NULL,
    eventType CHAR(8)              ,
    PRIMARY KEY (event, discipline),
    FOREIGN KEY (discipline) REFERENCES Discipline(discipline) ON DELETE CASCADE
);
