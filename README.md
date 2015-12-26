# Docker Commands
`docker-machine create --driver virtualbox --virtualbox-disk-size 10000 --virtualbox-memory 2048 --virtualbox-cpu-count 4 dev`

`eval "$(docker-machine env dev)"`

`docker ps -al`

`docker commit <CONTAINER ID> <IMAGE ID>`

`docker rm -f <CONTAINER ID>`

`docker rmi -f <IMAGE ID>`

`docker build -t <REPOSITORY NAME>/<IMAGE NAME>:<TAG NAME> <DOCKERFILE PATH>`

`docker run -it -p <HOST PORT>:<CONTAINER PORT> -v <HOST DIR>:<CONTAINER DIR> -e <KEU>=<VALUE> <CONTAINER ID>`

`docker exec -it <CONTAINER ID> /bin/bash`

`docker-machine ip <MACHINE NAME>`

`docker-machine restart <MACHINE NAME>`

`docker inspect <CONTAINER ID> | grep "\"IPAddress\"" | head -1 | awk '{print $2}'`

`docker run -d -v ~/Workspace/docker/couchbase:/opt/couchbase/var -p 8091:8091 couchbase/server[:community]`

### Recursively stop and remove all containers
`docker ps -a | awk '!/CONTAINER/ {system("docker stop "$1); system("docker rm -f "$1)}'`

# Mount Host Directory from OS X:

`vboxmanage showvminfo dev`

From host:
`vboxmanage sharedfolder add <MACHINE NAME> --name <NAME OF SHARED DIR> --hostpath <PATH TO SHARED DIR> --transient`

`docker-machine ssh <MACHINE NAME>`

In Docker machine VM:

`mkdir <PATH TO SHARED DIR>`

`sudo mount -t vboxsf -o uid=$(id -u docker),gid=$(id -g docker) <NAME OF SHARED DIR> <PATH TO SHARED DIR>`

`sudo umount <PATH TO SHARED DIR>`

### Create a Patch:

`diff -abBu <ORIGINAL FILE> <MODIFIED FILE>`

# Useful References

[Developing Inside Docker Containers with OS X](pharnisc.github.io/2015/09/16/developing-inside-docker-containers-with-osx.html)

[Docker - Beginner's tutorial](https://blog.talpor.com/2015/01/docker-beginners-tutorial)

[Arun Gupta's Docker Images](https://github.com/arun-gupta/docker-images)


