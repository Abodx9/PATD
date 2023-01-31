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
# Simple SQL Query
```SQL
  How to get the name and address of all patients whose name  starts with "J" and live in "570 Gateway Lane"?
  
  Select Patient.name, Patient.surname,Patient.address
  from Patient
  where Patient.name LIKE'J%'
  AND Patient.address LIKE '%570 Gateway Lane%';

  ...
  
  Some SQL queries?



```
