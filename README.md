# Build Oracle Client 11g image
docker build -t cli12c --build-arg DISTRIB_URL=http://<localhost_ip_address>:8080/client .

# Run sqlplus container
docker run --rm -it -v $(pwd)/sql:/tmp/sql --link db:db cli12c bash

# Run siebel specific scripts
sqlplus 'sys/system@(DESCRIPTION=(ADDRESS=(PROTOCOL=tcp)(HOST=db)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=SIEBELDB))) as sysdba' < /tmp/sql/create-tablespace.sql

sqlplus 'sys/system@(DESCRIPTION=(ADDRESS=(PROTOCOL=tcp)(HOST=db)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=SIEBELDB))) as sysdba' < /tmp/sql/grandusr.sql

sqlplus 'siebel/siebel@(DESCRIPTION=(ADDRESS=(PROTOCOL=tcp)(HOST=db)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=SIEBELDB)))'
