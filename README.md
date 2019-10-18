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
```
docker run -d -p 30081:80 --name=sandbox1 -h sandbox1 qoriq/arm64-ubuntu bash -c "lighttpd -f /etc/lighttpd/lighttpd.conf -D"
```
- run - create and start the container. Optionally, download the image if not available on the host.
- -d - start the container as a daemon.
- -p 30081:80 - forward port 80 in the container to port 30081 on the board.
- --name=sandbox1 - the name of the container (as visible to Docker).
- -h sandbox1 - the hostname inside the container.
- bash -c "lighttpd -f /etc/lighttpd/lighttpd.conf -D" - the command to execute as PID 1 in the container.


## Reference
- https://docs.docker.com/engine/examples/running_ssh_service/
