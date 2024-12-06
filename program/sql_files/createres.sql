DROP TABLE IF EXISTS Results;
CREATE TABLE Results(
    medal SMALLINT          NOT NULL,
    discipline VARCHAR(50)  NOT NULL,
    event VARCHAR(50)       NOT NULL,
    athleteCode VARCHAR(7)          ,
    teamCode VARCHAR(17)            ,

    UNIQUE(medal, event, discipline, athleteCode),
    UNIQUE(medal, event, discipline, teamCode),

    FOREIGN KEY (athleteCode) REFERENCES Athlete(athleteCode) ON DELETE CASCADE,
    FOREIGN KEY (teamCode) REFERENCES Team(teamCode) ON DELETE CASCADE,
    FOREIGN KEY (event) REFERENCES Event(event) ON DELETE CASCADE,
    FOREIGN KEY (discipline) REFERENCES Discipline(discipline) ON DELETE CASCADE
);
