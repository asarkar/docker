Following environment variables are accepted:
   * ROOT_PASSWORD - Required: No. Default: `changeit`.
   * USER - Username/password of a new user. Format is `USERNAME:PASSWORD`. Default: `appuser:changeit`. Required: No.

A SQL file can be executed at startup by first mounting the directory that contains it using `-v <HOST DIR>:<SOME DIR>` and then running the image with absolute path of the SQL file as the command. File extension must be `.sql`. Schema name is derived from the name of the file, without the extension. The new user is granted `SELECT` only access to the schema. The default is the MySQL 'world' schema that's passed to the entrypoint by the command.
Required: No.

Note: Due to the hassle of mounting host directory from OS X, only `/tmp/mysql:/usr/local/share/mysql` is permanently mounted.

Example:
`docker run -it -v /tmp/mysql:/usr/local/share/mysql -p 3306:3306 <IMAGE ID> "/usr/local/share/mysql/data.sql"`

### Back up existing MySQL database:

`mysqldump -h OLDHOST -u OLDUSER -pOLDPASS --default-character-set=utf8mb4 --result-file=backup.sql OLDDATABASE`

### Import into new MySQL database:

`mysql -h NEWHOST -u NEWUSER -pNEWPASS --default-character-set=utf8mb4 NEWDATABASE`
`SET names='utf8mb4'`
`SOURCE backup.sql`

The arguments `NEW*` are dereived from the database URL mysql://NEWUSER:NEWPASS@NEWHOST:3306/NEWDATABASE

### Connect to remote MySQL server:

`mysql -h NEWHOST -u NEWUSER -pNEWPASS [NEWDATABASE]`

### Show charset related variables:

`SHOW VARIABLES WHERE Variable_name LIKE 'character\_set\_%' OR Variable_name LIKE 'collation%';`