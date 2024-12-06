DROP TABLE IF EXISTS Location;
CREATE TABLE Location (
    startDate DATE                  ,
    endDate DATE                    ,
    discipline VARCHAR(50)  NOT NULL,
    event VARCHAR(50)       NOT NULL,
    phase VARCHAR(50)        NOT NULL,
    venueCode VARCHAR(3)    NOT NULL,
    startTime TIME                  ,
    endTime TIME                    ,

    PRIMARY KEY(startDate, startTime, discipline, event, phase),

    FOREIGN KEY (venueCode) REFERENCES Venue(venueCode) ON DELETE CASCADE,
    FOREIGN KEY (event) REFERENCES Event(event) ON DELETE CASCADE,
    FOREIGN KEY (discipline) REFERENCES Discipline(discipline) ON DELETE CASCADE
);
