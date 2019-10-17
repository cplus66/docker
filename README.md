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

## Reference
- https://docs.docker.com/engine/examples/running_ssh_service/
