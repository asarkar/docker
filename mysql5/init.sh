#!/bin/bash

DATAFILE=/tmp/world.sql

/usr/sbin/mysqld &
	sleep 5

mysql -s --show-warnings <<EOF
	UPDATE mysql.user SET host='%' WHERE host = 'localhost';
	UPDATE mysql.user SET Grant_priv='Y', Super_priv='Y' WHERE User='root';
	FLUSH PRIVILEGES;
	GRANT ALL PRIVILEGES ON *.* TO 'root'@'%'; FLUSH PRIVILEGES;	
EOF

mysql -s --show-warnings < $DATAFILE && \
	rm -f $DATAFILE

echo "GRANT SELECT ON world.* TO 'test'@'%' IDENTIFIED BY 'changeit'; FLUSH PRIVILEGES;" | mysql

mysqladmin -s --show-warnings shutdown && \
	supervisord -c /etc/supervisord.conf
