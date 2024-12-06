-- had to resort to removing database as mysql-connector doesn't want
-- work properly otherwise

DROP DATABASE IF EXISTS olympics_20864846;
CREATE DATABASE olympics_20864846;
USE olympics_20864846;

-- creating all the tables

SOURCE createcou.sql;
SOURCE createdis.sql;
SOURCE createath.sql;
SOURCE createtea.sql;
SOURCE createven.sql;
SOURCE createeve.sql;
SOURCE createpao.sql;
SOURCE createres.sql;
SOURCE createloc.sql;
SOURCE createpar.sql;
