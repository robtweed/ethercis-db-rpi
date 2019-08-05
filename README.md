# ethercis-db-rpi

## EtherCIS version 1.3 Database Container for Raspberry Pi

This is based on and derived from the original 
[RippleOSI EtherCIS Database Docker Container](https://github.com/ethercis/ethercis-database-docker),
but updated and patched for use with EtherCIS version 1.3, and ported to run on the Raspberry Pi.

This Docker Container must be used in conjunction with the 
[ethercis-server-rpi](https://github.com/robtweed/ethercis-server-rpi) Container.

Prebuilt docker images for both are available on the Docker Hub:

- rtweed/ethercis-db-rpi
- rtweed/ethercis-server-rpi


## Loading and Running the EtherCIS Database

This container is designed to run on a Raspberry Pi.  For the best performance, a
Raspberry Pi 4 is recommended.


1) Install Docker (if not already installed):


        curl -sSL https://get.docker.com | sh

To avoid using *sudo* when running *docker* commands:

        sudo usermod -aG docker ${USER}
        su - ${USER}

  NB: You'll be asked to enter your Linux password


2) Load the Container

        docker pull rtweed/ethercis-db-rpi


3) Create a Docker Network

        docker network create ecis-net

Confirm that it's been created by listing your Docker networks

        docker network ls

You should see ecis-net included in the list as a *bridged* network


3) Running the Container

        docker run -it --rm --name ethercis-db --net ecis-net -p 5432:5432 rtweed/ethercis-db-rpi

After a few seconds, the EtherCIS/Postgres database will be ready for use, listening on the
default Postgres port: 5432

Note: The Postgres database username and password are *postgres* and *postgres*


## Testing the EtherCIS Database

This is most easily done using the PgAdmin tool, and the easiest way to install and run
PgAdmin is to use a Dockerised version:

1) Load the PgAdmin Container

        docker pull dpage/pgadmin4

2) Start the PgAdmin Container

        docker run -it --rm --name pgadmin -p 80:80 -e "PGADMIN_DEFAULT_EMAIL=rob.tweed@gmail.com" -e "PGADMIN_DEFAULT_PASSWORD=secret" dpage/pgadmin4

Note: change the *PGADMIN_DEFAULT_EMAIL* value to your email address and you might want to specify
a different password also!

3) Start PgAdmin

- Point a browser at the IP address of the machine hosting the PgAdmin Container, eg:

        http://192.168.1.200

- Login using the username and password you specified in the *docker run* command

- Add the EtherCIS database using the following credentials:

  - General/Name: ethercis
  - Connection:
    - Host name/address: {{ip address of machine hosting the EtherCIS database container}}  (eg 192.168.1.200)
    - Port: 5432
    - Maintenance database: postgres
    - Username: postgres
    - Password: postgres

- Click Save and you should see the EtherCIS database appearing as a server in the left panel

If so, then you have successfully started up the EtherCIS database.



## Acknowledgements
* The early origins of this repo came from https://github.com/inidus/ethercis-docker by [Seref Arikan](https://github.com/serefarikan)
* Also helpful was this other EtherCIS docker setup https://github.com/alessfg/docker-ethercis

