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
