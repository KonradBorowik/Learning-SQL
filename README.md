# SQL upskilling

## Setup MySQL

1. Install mysql [on wsl](https://learn.microsoft.com/en-us/windows/wsl/tutorials/wsl-database)

2. Enter mysql shell
```bash
sudo mysql
```

3. Add new database
```sql
CREATE DATABASE <your_db_name>;
```

4. Switch to the database
```sql
USE <your_db_name>;
```

5. Create tables with tables.sql
```sql
source </path/to/folder> /tables.sql
```

6. Run all queries at once
```sql
source </path/to/folder> /queries.sql
```
Alternatively use PopSQL or other SQL editor to run queries separately.

7. To test triggers copy and paste queries to MySQL shell 