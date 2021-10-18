# docker-utils
Collect useful docker commands.

## Usage
./docker.sh { create | exec | start | stop | status | install | clean | pull }

## SSH Server

### Build Image
```
docker build -t openssh-server .
```

### Run Container
```
docker run -d -P --name prj-id-1 openssh-server
docker port sshd-1 22
```

## Admin and Maintenance
### Backup a Container
```
docker commit -p [container-id] backup01
docker save -o backup01.tar backup01
```

### Restore a Container
```
docker load -i /tmp/backup01.tar
```

## Docker Swarm

### Manager
```
docker swarm init
docker network create -d overlay rd-net
```

Show join-token command for both worker and manager
```
docker swarm join-token manager
```

### Worker
```
docker swarm join --token <your_token> <your_ip_address>:2377
```

### Run Docker Service
```
docker service create --name prj-id-1 --publish target=22,published=10120 --replicas=1 \
--network rd-net openssh-server:0.1
```

## Docker Hub

### Tag Docker Image
```
docker image tag bulletinboard:1.0 gordon/bulletinboard:1.0
```
Image name: \<Docker Hub ID\>/\<Repository Name\>:\<tag\>

### Push Docker Image
```
docker login
docker image push gordon/bulletinboard:1.0
```

## Reference
### Installation
- https://www.linuxtechi.com/install-kubernetes-1-7-centos7-rhel7/

### OpenSSH container
- https://docs.docker.com/engine/examples/running_ssh_service/
- https://www.thegeekdiary.com/how-to-backup-and-restore-docker-containers/
- https://leadwithoutatitle.wordpress.com/2018/03/07/how-to-create-an-ssh-enabled-docker-container-using-kubernetes/

### Network
- https://docs.docker.com/network/network-tutorial-overlay/

### Admin Guide
- https://docs.docker.com/engine/swarm/admin_guide/
- https://docs.docker.com/engine/swarm/swarm-tutorial/

### Pushing and Pulling to and from Docker Hub
- https://ropenscilabs.github.io/r-docker-tutorial/04-Dockerhub.html

## Others
### NXP QorIQ SDK
```
docker run -d -p 30081:80 --name=sandbox1 -h sandbox1 qoriq/arm64-ubuntu \
    bash -c "lighttpd -f /etc/lighttpd/lighttpd.conf -D"
```
- run - create and start the container. Optionally, download the image if not available on the host.
- -d - start the container as a daemon.
- -p 30081:80 - forward port 80 in the container to port 30081 on the board.
- --name=sandbox1 - the name of the container (as visible to Docker).
- -h sandbox1 - the hostname inside the container.
- bash -c "lighttpd -f /etc/lighttpd/lighttpd.conf -D" - the command to execute as PID 1 in the container.

## Build Yocto 3.3.3 from Yocto 3.1.11 Docker Environment
```
mkdir build
chown 30000:30000 build
docker run -it --rm -u 30000 -v /home/root/build:/project gmacario/build-yocto

build@56c26aea6341:~$ cd /project/
build@56c26aea6341:/project$ curl -O http://downloads.yoctoproject.org/releases/yocto/yocto-3.3.3/poky-hardknott-25.0.3.tar.bz2
build@56c26aea6341:/project$ tar xjf poky-hardknott-25.0.3.tar.bz2
build@56c26aea6341:/project$ cd poky-hardknott-25.0.3
build@56c26aea6341:/project/poky-hardknott-25.0.3$ source ./oe-init-build-env
build@56c26aea6341:/project/poky-hardknott-25.0.3/build$ bitbake core-image-minimal
```
