#!/bin/bash
set -e

echo "Start installation..."

echo "-> Download distributives"
mkdir -p ${DISTRIB_FOLDER}

echo "Fetiching ${DISTRIB_URL}/oracle-instantclient11.2-basic-11.2.0.4.0-1.i386.rpm"
curl -L -o ${DISTRIB_FOLDER}/oracle-instantclient11.2-basic-11.2.0.4.0-1.i386.rpm ${DISTRIB_URL}/oracle-instantclient11.2-basic-11.2.0.4.0-1.i386.rpm
echo "Fetiching ${DISTRIB_URL}/oracle-instantclient11.2-sqlplus-11.2.0.4.0-1.i386.rpm"
curl -L -o ${DISTRIB_FOLDER}/oracle-instantclient11.2-sqlplus-11.2.0.4.0-1.i386.rpm ${DISTRIB_URL}/oracle-instantclient11.2-sqlplus-11.2.0.4.0-1.i386.rpm

echo "-> Install..."
yum localinstall -y ${DISTRIB_FOLDER}/oracle-instantclient11.2-basic-11.2.0.4.0-1.i386.rpm
yum localinstall -y ${DISTRIB_FOLDER}/oracle-instantclient11.2-sqlplus-11.2.0.4.0-1.i386.rpm
yum clean all

echo "-> Fix lib problem..."
cd /usr/lib/oracle/11.2/client/lib/
ln -s libclntsh.so.11.1 libclntsh.so

echo "-> Remove distributives"
rm -fr ${DISTRIB_FOLDER};
