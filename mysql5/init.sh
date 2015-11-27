#!/bin/bash

/usr/sbin/mysqld &
sleep 5

mysql -s <<EOF
	UPDATE mysql.user SET host='%' WHERE host = 'localhost';
	UPDATE mysql.user SET Grant_priv='Y', Super_priv='Y' WHERE User='root';
	FLUSH PRIVILEGES;
	GRANT ALL PRIVILEGES ON *.* TO 'root'@'%'; FLUSH PRIVILEGES;	
EOF

IFS=':' read -ra FIELDS <<< "$USER"

USERNAME=${FIELDS[0]}
PASSWORD=${FIELDS[1]}

DEFAULT_USERNAME=appuser
DEFAULT_PASSWORD=changeit

if [ -z "$USERNAME" ]; then
	printf "[WARN] Username not provided. Defaulting to '%s'.\n" "$DEFAULT_USERNAME"
fi
if [ -z "$PASSWORD" ]; then
	printf "[WARN] User password not set. Defaulting to '%s'.\n" "$DEFAULT_PASSWORD"
fi
if [ -z "$ROOT_PASSWORD" ]; then
	printf "[WARN] root password not set. Defaulting to '%s'.\n" "$DEFAULT_PASSWORD"
fi

USERNAME=${USERNAME:-$(echo $DEFAULT_USERNAME)}
PASSWORD=${PASSWORD:-$(echo $DEFAULT_PASSWORD)}
ROOT_PASSWORD=${ROOT_PASSWORD:-$(echo $DEFAULT_PASSWORD)}

echo "CREATE USER IF NOT EXISTS '$USERNAME'@'%' IDENTIFIED BY '$PASSWORD';" | mysql

DATAFILE="$1"

if [[ "$DATAFILE" =~ .*\.sql$ ]] && [ -f "$DATAFILE" ]; then
	SCHEMA=$(basename "$DATAFILE" .sql)

	printf "[INFO] Importing datafile: %s into schema: '%s'.\n" "$DATAFILE" "$SCHEMA"

	# - is necessary if tab if used before end of heredoc string (EOF)
	mysql -s <<-EOF
		DROP SCHEMA IF EXISTS $SCHEMA;
		CREATE SCHEMA $SCHEMA;
		GRANT SELECT ON $SCHEMA.* TO '$USERNAME'@'%';
		FLUSH PRIVILEGES;
	EOF

	mysql -s $SCHEMA < "$DATAFILE"
fi

echo "ALTER USER 'root'@'%' IDENTIFIED BY '$ROOT_PASSWORD';" | mysql

# No space between -p and password
mysqladmin -s -u root -p$ROOT_PASSWORD shutdown && \
	supervisord -c /etc/supervisord.conf
