#!/bin/bash

DATAFILE=/tmp/world.sql

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

DEFAULT_USERNAME=testuser
DEFAULT_PASSWORD=changeit

if [ -z "$USERNAME" ]; then
	printf "[WARN] Username not provided. Defaulting to '$DEFAULT_USERNAME'.\n"
fi
if [ -z "$PASSWORD" ]; then
	printf "[WARN] User password not set. Defaulting to '$DEFAULT_PASSWORD'.\n"
fi
if [ -z "$ROOT_PASSWORD" ]; then
	printf "[WARN] root password not set. Defaulting to '$DEFAULT_PASSWORD'.\n"
fi

USERNAME=${USERNAME:-$(echo $DEFAULT_USERNAME)}
PASSWORD=${PASSWORD:-$(echo $DEFAULT_PASSWORD)}
ROOT_PASSWORD=${ROOT_PASSWORD:-$(echo $DEFAULT_PASSWORD)}

echo "CREATE USER IF NOT EXISTS '$USERNAME'@'%' IDENTIFIED BY '$PASSWORD';" | mysql

echo "GRANT SELECT ON world.* TO '$USERNAME'@'%'; FLUSH PRIVILEGES;" | mysql

mysql -s < $DATAFILE

rm -f $DATAFILE

echo "ALTER USER 'root'@'%' IDENTIFIED BY '$ROOT_PASSWORD';" | mysql

# No space between -p and password
mysqladmin -s -u root -p$ROOT_PASSWORD shutdown && \
	supervisord -c /etc/supervisord.conf
