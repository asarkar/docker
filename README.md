# Docker Machine Commands
`docker-machine create --driver virtualbox --virtualbox-disk-size 10000 --virtualbox-memory 2048 --virtualbox-cpu-count 4 <MACHINE NAME>`

`eval "$(docker-machine env <MACHINE NAME>)"`

### Push to insecure registry:
   * Log into the docker machine `docker-machine ssh <MACHINE NAME>`
   * Change to root `sudo -i`
   * Edit or create the file `/var/lib/boot2docker/profile` and add the following line to `EXTRA_ARGS`: `--insecure-registry <REGISTRY HOST>:<REGISTRY PORT>`
   * Restart Docker daemon: `sudo /etc/init.d/docker restart`

`docker-machine ip <MACHINE NAME>`

`docker-machine restart <MACHINE NAME>`

# Docker Commands

`docker ps -al`

`docker commit <CONTAINER ID> <IMAGE ID>`

`docker rm -f <CONTAINER ID>`

`docker rmi -f <IMAGE ID>`

`docker build -t <REPOSITORY NAME>/<IMAGE NAME>:<TAG NAME> <DOCKERFILE PATH>`

`docker run -it -p <HOST PORT>:<CONTAINER PORT> -v <HOST DIR>:<CONTAINER DIR> -e <KEU>=<VALUE> <CONTAINER ID>`

`docker exec -it <CONTAINER ID> /bin/bash`

`docker inspect <CONTAINER ID> | grep "\"IPAddress\"" | head -1 | awk '{print $2}'`

`docker run -d -v ~/Workspace/docker/couchbase:/opt/couchbase/var -p 8091:8091 couchbase/server[:community]`

### Clean up:
https://getintodevops.com/blog/keeping-the-whale-happy-how-to-clean-up-after-docker

### Free local disk space:
`docker run --rm -v /var/run/docker.sock:/var/run/docker.sock:ro -v /var/lib/docker:/var/lib/docker martin/docker-cleanup-volumes`

# Mount Host Directory from OS X:

`vboxmanage showvminfo dev`

From host:
`vboxmanage sharedfolder add <MACHINE NAME> --name <NAME OF SHARED DIR> --hostpath <PATH TO SHARED DIR> --transient`

`docker-machine ssh <MACHINE NAME>`

In Docker machine VM:

`mkdir <PATH TO SHARED DIR>`

`sudo mount -t vboxsf -o uid=$(id -u docker),gid=$(id -g docker) <NAME OF SHARED DIR> <PATH TO SHARED DIR>`

`sudo umount <PATH TO SHARED DIR>`

# Minikube Commands

```
eval $(minikube docker-env)

eval $(minikube docker-env -u)

minikube dashboard

minikube addons list

minikube addons enable ingress

minikube start --extra-config=apiserver.AuthorizationMode=RBAC

```

c.f. [Setting up Ingress on Minikube](https://medium.com/@Oskarr3/setting-up-ingress-on-minikube-6ae825e98f82)

# kubectl Commands

```
kubectl create -f <filename>

kubectl logs couchbase-node-0

kubectl run -i --tty --image busybox dns-test --restart=Never --rm /bin/sh

kubectl delete <kind> <name> --grace-period=0 --force

kubectl cluster-info

kubectl cp <namespace>/<pod>:<file> <local file>

kubectl get po --field-selector=status.phase==Running -l app=k8s-watcher

```

### Access Clusters Using the Kubernetes API

```
APISERVER=$(kubectl config view | grep server | cut -f 2- -d ":" | tr -d " ")
TOKEN=$(kubectl describe secret $(kubectl get secrets | grep default | cut -f1 -d ' ') | grep -E '^token' | cut -f2 -d':' | tr -d '\t' | tr -d '[:space:]')
curl $APISERVER/api/v1/namespaces/default/pods --header "Authorization: Bearer $TOKEN" --insecure
```

> If RBAC is enabled, instead of grepping the `default` service account token, grep the one that has access.

# Useful References

[Access Clusters Using the Kubernetes API](https://kubernetes.io/docs/tasks/administer-cluster/access-cluster-api/#without-kubectl-proxy)

[Developing Inside Docker Containers with OS X](pharnisc.github.io/2015/09/16/developing-inside-docker-containers-with-osx.html)

[Docker - Beginner's tutorial](https://blog.talpor.com/2015/01/docker-beginners-tutorial)

[Arun Gupta's Docker Images](https://github.com/arun-gupta/docker-images)
