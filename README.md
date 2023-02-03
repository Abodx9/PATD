# PATD
The whole implementation  of our Database including the ERM diagram and some Informations


**Our SQL queries are split up into two separate files so far. Each of these files has a different function to keep the total query runtime as low as possible. The entirety of the data is already live and accessible in the database in accordance with the data presented in these queries.**

**am_medrounds BUILD.sql**

```
This query creates all the tables, sets some important parameters and defines every set of permissions in the database. These permissions are also commented.
```

**am_medrounds INSERT.sql**

```
This query inserts all the auto-generated data from SQLer (https://github.com/Abodx9/sqler) into the previously created tables.
```
# Some SQL Queries
 How to get the name and address of all patients whose name  starts with "J" and live in "570 Gateway Lane"?
```SQL
  Select Patient.name, Patient.surname,Patient.address
  from Patient
  where Patient.name LIKE'J%'
  AND Patient.address LIKE '%570 Gateway Lane%';
```
 How to retrieve the names of the patients who are being treated by a specific doctor?
  ```SQL
SELECT Patient.patID, Patient.name, Patient.surname
FROM Patient 
JOIN treats ON Patient.patID = treats.patient 
JOIN Doctors ON Doctors.employeeID = treats.doctor
WHERE Doctors.name = 'Doctor Name';
```
  How to retrieve the number of patients in each ward?
  
  ```SQL
SELECT Ward.wardNumber, COUNT(Patient.patID) AS patientCount
FROM Ward 
JOIN Rooms ON Ward.wardNumber = Rooms.wardNumber
JOIN liesInBed ON Rooms.roomNumber = liesInBed.roomNumber
JOIN Patient ON Patient.patID = liesInBed.patID
GROUP BY Ward.wardNumber;
```





