FROM tobi312/rpi-postgresql

# Default to UTF-8 file.encoding
ENV LANG C.UTF-8

RUN apt update
RUN apt-get install -y openjdk-8-jdk-headless
RUN apt-get install -y python python-dev pgxnclient git
RUN apt-get install -y postgresql-contrib
RUN apt-get install -y build-essential make
RUN apt-get install -y postgresql-server-dev-all postgresql-common
RUN apt-get install -y libpq-dev
RUN apt-get install -y ca-certificates
RUN apt-get install -y bison flex wget unzip

RUN mkdir -p /var/lib/postgresql/pgdata
ENV PGDATA  /var/lib/postgresql/pgdata

#ETHERCIS: add files
ADD customise.sh /
ADD v9_migration.sql /
ADD pg_hba.conf /

RUN chmod +x /customise.sh

RUN  sh  -c " /docker-entrypoint.sh postgres & "  && sleep 20 &&  /customise.sh
