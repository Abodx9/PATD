--
-- PostgreSQL
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;


SET default_tablespace = '';

SET default_with_oids = false;

--DROP TABLE STATEMENTS, just to clear the data for possibly newly added inserts;
DROP TABLE IF EXISTS Patient CASCADE;
DROP TABLE IF EXISTS Nurses CASCADE;
DROP TABLE IF EXISTS Doctors CASCADE;
DROP TABLE IF EXISTS Medication CASCADE;
DROP TABLE IF EXISTS Rooms CASCADE;
DROP TABLE IF EXISTS Ward CASCADE;
DROP TABLE IF EXISTS liesInBed CASCADE;
DROP TABLE IF EXISTS treats CASCADE;
DROP TABLE IF EXISTS administersTo CASCADE;
DROP TABLE IF EXISTS caresFor CASCADE; 

--CREATE TABLE STATEMENTS;

CREATE TABLE IF NOT EXISTS Ward (
        wardNumber integer NOT NULL,
        stationName varchar(60) NOT NULL,
        PRIMARY KEY(wardNumber)
); 

CREATE TABLE IF NOT EXISTS Doctors (
        employeeID integer NOT NULL,
        name varchar(45) NOT NULL,
        surname varchar(45) NOT NULL,
        dob date NOT NULL,
        wardNumber integer not NULL,
        FOREIGN KEY(wardNumber) REFERENCES Ward(wardNumber),
        PRIMARY KEY(employeeID) 
);

CREATE TABLE IF NOT EXISTS Patient (
        patID integer NOT NULL,
        name varchar(45) NOT NULL,
        surname varchar(45) NOT NULL,
        dob DATE NOT NULL,
        sex varchar(10) NOT NULL,
        patientFIle integer NOT NULL,
        status varchar(30),
        insuranceNumber integer NOT NULL,
        address text NOT NULL,
        PRIMARY KEY(patID)
);

CREATE TABLE IF NOT EXISTS Nurses (
        employeeID integer NOT NULL,
        name varchar(45) NOT NULL,
        surname varchar(45) NOT NULL,
        dob date NOT NULL,
        wardNumber integer NOT NULL,
        FOREIGN KEY(wardNumber) REFERENCES Ward(wardNumber),
        PRIMARY KEY(employeeID)
);

CREATE TABLE IF NOT EXISTS Medication (
        doseID serial NOT NULL,
        content text NOT NULL,
        dosage varchar(8) NOT NULL,
        preparedBy integer NOT NULL,
        FOREIGN KEY(preparedBy) REFERENCES Doctors(employeeID),
        PRIMARY KEY(doseID)
);

CREATE TABLE IF NOT EXISTS Rooms (
        roomNumber integer NOT NULL,
        wardNumber integer NOT NULL,
        FOREIGN KEY(wardNumber) REFERENCES Ward(wardNumber),
        PRIMARY KEY(roomNumber)
);

CREATE TABLE IF NOT EXISTS liesInBed (
        bedID integer NOT NULL, 
        roomNumber integer NOT NULL,
        patID integer NOT NULL,
        FOREIGN KEY(roomNumber) REFERENCES Rooms(roomNumber),
        FOREIGN KEY(patID) REFERENCES Patient(patID),
        PRIMARY KEY(bedID)
);

CREATE TABLE IF NOT EXISTS treats (
        timeOfTreatment timestamp NOT NULL,
        treatmentNote text NOT NULL,
        treatment varchar(500),
        releasable boolean NOT NULL,
        patient integer NOT NULL,
        doctor integer NOT NULL, 
        FOREIGN KEY(patient) REFERENCES Patient(patID),
        FOREIGN KEY(doctor) REFERENCES Doctors(employeeID),
        PRIMARY KEY(timeOfTreatment)
);

CREATE TABLE IF NOT EXISTS administersTo (
        timeOfAdministration timestamp NOT NULL,
        doseID serial NOT NULL,
        nurse integer NOT NULL,
        patient integer NOT NULL,
        FOREIGN KEY(patient) REFERENCES Patient(patID),
        FOREIGN KEY(doseID) REFERENCES Medication(doseID),
        FOREIGN KEY(nurse) REFERENCES Nurses(employeeID),
        PRIMARY KEY(timeOfAdministration)
);

CREATE TABLE IF NOT EXISTS caresFor (
        timeOfCare timestamp NOT NULL,
        nurse integer NOT NULL,
        patient integer NOT NULL,
        FOREIGN KEY(nurse) REFERENCES Nurses(employeeID),
        FOREIGN KEY(patient) REFERENCES Patient(patID),
        PRIMARY KEY(timeOfCare)
);

--GRANTING FULL PERMISSIONS TO ABDUL AND MRS. KNAUT;

GRANT ALL PRIVILEGES ON Ward TO am_medrounds_abdul;
GRANT ALL PRIVILEGES ON Doctors TO am_medrounds_abdul;
GRANT ALL PRIVILEGES ON Patient TO am_medrounds_abdul;
GRANT ALL PRIVILEGES ON Nurses TO am_medrounds_abdul;
GRANT ALL PRIVILEGES ON Medication TO am_medrounds_abdul;
GRANT ALL PRIVILEGES ON Rooms TO am_medrounds_abdul;
GRANT ALL PRIVILEGES ON liesInBed TO am_medrounds_abdul;
GRANT ALL PRIVILEGES ON treats TO am_medrounds_abdul;
GRANT ALL PRIVILEGES ON administersTo TO am_medrounds_abdul;
GRANT ALL PRIVILEGES ON caresFor TO am_medrounds_abdul;

GRANT SELECT ON Ward TO am_medrounds_knaut;
GRANT SELECT ON Doctors TO am_medrounds_knaut;
GRANT SELECT ON Patient TO am_medrounds_knaut;
GRANT SELECT ON Nurses TO am_medrounds_knaut;
GRANT SELECT ON Medication TO am_medrounds_knaut;
GRANT SELECT ON Rooms TO am_medrounds_knaut;
GRANT SELECT ON treats TO am_medrounds_knaut;
GRANT SELECT ON administersTo TO am_medrounds_knaut;
GRANT SELECT ON caresFor TO am_medrounds_knaut;

GRANT SELECT ON Ward TO am_medrounds_class;
GRANT SELECT ON Doctors TO am_medrounds_class;
GRANT SELECT ON Patient TO am_medrounds_class;
GRANT SELECT ON Nurses TO am_medrounds_class;
GRANT SELECT ON Medication TO am_medrounds_class;
GRANT SELECT ON Rooms TO am_medrounds_class;
GRANT SELECT ON treats TO am_medrounds_class;
GRANT SELECT ON administersTo TO am_medrounds_class;
GRANT SELECT ON caresFor TO am_medrounds_class;

/* GIVING LIMITED SETS OF PERMISSIONS HERE TO ALLOW IOT DEVICES
RUN CERTAIN FUNCTIONS AND PROTECT THE DATA THROUGH INDIRECT ACCESS.
IN REALITY IT WOULD NOT BE FEASIBLE FOR NURSES TO ENTER ALL THE CARE DATA
FOR EVERY INDIVIDUAL PATIENT AFTER EVERYTIME THEY DID MEDICAL CARE.
THEREFORE IT IS REQUIRED TO HAVE A DECT ELEMENT AND A CONTROLLER THAT WRITES
INTO THE DATABASE BASED ON THE NURSE's ID WITH A SET OF PREDEFINED VALUES.
THIS ALLOWS THE NURSE TO ENTER EVERYTHING AT THE PRESS OF A BUTTON AND HAVE IT BE TRACEABLE
THROUGH THE ID's AND TIMESTAMPS WE HAVE IN THE SCHEME. 

UNFORTUNATELY I WAS NOT ABLE TO GIVE PERMISSIONS OTHER THAN
SELECT, INSERT, UPDATE OR DELETE DUE TO THE PERMISSIONS DEFINED IN OCEAN*/

GRANT SELECT ON Ward TO am_medrounds_nurse;
GRANT SELECT ON Doctors TO am_medrounds_nurse;
GRANT SELECT ON Patient TO am_medrounds_nurse;
GRANT SELECT ON Nurses TO am_medrounds_nurse;
GRANT SELECT ON Medication TO am_medrounds_nurse;
GRANT SELECT ON Rooms TO am_medrounds_nurse;
GRANT SELECT ON liesInBed TO am_medrounds_nurse;
GRANT SELECT ON caresFor TO am_medrounds_nurse;
GRANT SELECT ON administersTo TO am_medrounds_nurse;
GRANT SELECT ON treats TO am_medrounds_nurse;

GRANT SELECT ON Ward TO am_medrounds_doctor;
GRANT SELECT ON Doctors TO am_medrounds_doctor;
GRANT SELECT ON Patient TO am_medrounds_doctor;
GRANT SELECT ON Nurses TO am_medrounds_doctor;
GRANT SELECT ON Medication TO am_medrounds_doctor; 
GRANT SELECT ON Rooms TO am_medrounds_doctor;
GRANT SELECT ON liesInBed TO am_medrounds_doctor;
GRANT SELECT ON caresFor TO am_medrounds_doctor; 
GRANT SELECT ON administersTo TO am_medrounds_doctor;
GRANT SELECT ON treats TO am_medrounds_doctor;
GRANT INSERT ON Ward TO am_medrounds_doctor;
GRANT INSERT ON Doctors TO am_medrounds_doctor;
GRANT INSERT ON Patient TO am_medrounds_doctor;
GRANT INSERT ON Nurses TO am_medrounds_doctor;
GRANT INSERT ON Medication TO am_medrounds_doctor; 
GRANT INSERT ON Rooms TO am_medrounds_doctor;
GRANT INSERT ON liesInBed TO am_medrounds_doctor;
GRANT INSERT ON caresFor TO am_medrounds_doctor; 
GRANT INSERT ON administersTo TO am_medrounds_doctor;
GRANT INSERT ON treats TO am_medrounds_doctor;

-- zero knowledge encryption
-- the element that is in the room, having visibility, sending the command to the controller thats centralised in a server room
GRANT SELECT ON Ward TO am_medrounds_dect;
GRANT SELECT ON Doctors TO am_medrounds_dect;
GRANT SELECT ON Patient TO am_medrounds_dect;
GRANT SELECT ON Nurses TO am_medrounds_dect;
GRANT SELECT ON Medication TO am_medrounds_dect; 
GRANT SELECT ON Rooms TO am_medrounds_dect;
GRANT SELECT ON liesInBed TO am_medrounds_dect;
GRANT SELECT ON caresFor TO am_medrounds_dect; 
GRANT SELECT ON administersTo TO am_medrounds_dect;
GRANT SELECT ON treats TO am_medrounds_dect;

-- the controller never has any direct view of the data but receives inputs from the dect, therefore no admin could abuse the controller
GRANT INSERT ON Ward TO am_medrounds_control;
GRANT INSERT ON Doctors TO am_medrounds_control;
GRANT INSERT ON Patient TO am_medrounds_control;
GRANT INSERT ON Nurses TO am_medrounds_control;
GRANT INSERT ON Medication TO am_medrounds_control; 
GRANT INSERT ON Rooms TO am_medrounds_control;
GRANT INSERT ON liesInBed TO am_medrounds_control; 
GRANT INSERT ON caresFor TO am_medrounds_control; 
GRANT INSERT ON administersTo TO am_medrounds_control;
GRANT INSERT ON treats TO am_medrounds_control;
GRANT UPDATE ON Ward TO am_medrounds_control;
GRANT UPDATE ON Doctors TO am_medrounds_control;
GRANT UPDATE ON Patient TO am_medrounds_control;
GRANT UPDATE ON Nurses TO am_medrounds_control;
GRANT UPDATE ON Medication TO am_medrounds_control; 
GRANT UPDATE ON Rooms TO am_medrounds_control;
GRANT UPDATE ON liesInBed TO am_medrounds_control;
GRANT UPDATE ON caresFor TO am_medrounds_control; 
GRANT UPDATE ON administersTo TO am_medrounds_control;
GRANT UPDATE ON treats TO am_medrounds_control;
GRANT DELETE ON Ward TO am_medrounds_control;
GRANT DELETE ON Doctors TO am_medrounds_control;
GRANT DELETE ON Patient TO am_medrounds_control;
GRANT DELETE ON Nurses TO am_medrounds_control;
GRANT DELETE ON Medication TO am_medrounds_control; 
GRANT DELETE ON Rooms TO am_medrounds_control;
GRANT DELETE ON liesInBed TO am_medrounds_control;
GRANT DELETE ON caresFor TO am_medrounds_control; 
GRANT DELETE ON administersTo TO am_medrounds_control;
GRANT DELETE ON treats TO am_medrounds_control;
GRANT TRUNCATE ON Ward TO am_medrounds_control;
GRANT TRUNCATE ON Doctors TO am_medrounds_control;
GRANT TRUNCATE ON Patient TO am_medrounds_control;
GRANT TRUNCATE ON Nurses TO am_medrounds_control;
GRANT TRUNCATE ON Medication TO am_medrounds_control; 
GRANT TRUNCATE ON Rooms TO am_medrounds_control;
GRANT TRUNCATE ON liesInBed TO am_medrounds_control;
GRANT TRUNCATE ON caresFor TO am_medrounds_control; 
GRANT TRUNCATE ON administersTo TO am_medrounds_control;
GRANT TRUNCATE ON treats TO am_medrounds_control;