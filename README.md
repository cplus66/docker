# docker
Collect useful docker commands.

## Usage
./docker.sh { create | exec | start | stop | status | install | clean | pull }

## SSH Server

### Build Image
```
docker build -t sshd .
```

### Run Container
```
docker run -d -P --name sshd-1 sshd
docker port sshd-1 22
```

## Useful Commands
### Launch a Container
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

### Backup a Container
```
docker commit -p [container-id] backup01
docker save -o backup01.tar backup01
```

### Restore a Container
```
docker load -i /tmp/backup01.tar
```

### Docker Hub

#### Tag Docker Image
```
docker image tag bulletinboard:1.0 gordon/bulletinboard:1.0
```
Image name: <Docker Hub ID>/<Repository Name>:<tag>

#### Push Docker Image
```
docker image push gordon/bulletinboard:1.0
```

## Reference
- https://docs.docker.com/engine/examples/running_ssh_service/
- https://www.thegeekdiary.com/how-to-backup-and-restore-docker-containers/
- https://leadwithoutatitle.wordpress.com/2018/03/07/how-to-create-an-ssh-enabled-docker-container-using-kubernetes/
- https://www.linuxtechi.com/install-kubernetes-1-7-centos7-rhel7/

