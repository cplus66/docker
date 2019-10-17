# docker
Create useful commands for using docker easier.

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
- https://docs.docker.com/engine/examples/running\_ssh\_service/
