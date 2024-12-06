DROP TABLE IF EXISTS Participate;
CREATE TABLE Participate (
    athleteCode VARCHAR(7)            ,
    discipline VARCHAR(50)    NOT NULL,
    event VARCHAR(50)         NOT NULL,
    teamCode VARCHAR(17)              ,

    UNIQUE (athleteCode, event, discipline),
    UNIQUE (teamCode, event, discipline),

    CONSTRAINT code_not_null CHECK ((athleteCode IS NOT NULL AND teamCode IS NULL) OR (athleteCode IS NULL AND teamCode IS NOT NULL)),

    FOREIGN KEY (event) REFERENCES Event(event) ON DELETE CASCADE,
    FOREIGN KEY (discipline) REFERENCES Discipline(discipline) ON DELETE CASCADE
);
