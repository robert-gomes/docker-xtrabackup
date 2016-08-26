FROM debian:jessie
MAINTAINER Martin Helmich <m.helmich@mittwald.de>

RUN apt-key adv --keyserver keys.gnupg.net --recv-keys 1C4CBDCDCD2EFD2A
RUN echo "deb http://repo.percona.com/apt vivid main" >> /etc/apt/sources.list && \
    apt-get update
RUN apt-get install -y percona-xtrabackup

VOLUME /var/backup/mysql

CMD xtrabackup --backup --user=root --password=$MYSQL_ROOT_PASSWORD --datadir /var/lib/mysql --target-dir=/backup && \
    xtrabackup --prepare --target-dir=/backup && \
    xtrabackup --prepare --target-dir=/backup
