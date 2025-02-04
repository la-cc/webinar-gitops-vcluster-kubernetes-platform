# select docker image
IGOR_DOCKER_IMAGE=webinar-templater:0.0.0
IGOR_DOCKER_COMMAND=                          # run this command inside the docker container
IGOR_DOCKER_PULL=0                            # force pulling the image before starting the container (0/1)
IGOR_DOCKER_RM=1                              # remove container on exit (0/1)
IGOR_DOCKER_TTY=1                             # open an interactive tty (0/1)
IGOR_DOCKER_USER=$(id -u)                     # run commands inside the container with this user
IGOR_DOCKER_GROUP=$(id -g)                    # run commands inside the container with this group
IGOR_DOCKER_ARGS=''                           # default arguments to docker run
IGOR_PORTS=''                                 # space separated list of ports to expose
IGOR_MOUNT_PASSWD=1                           # mount /etc/passwd inside the container (0/1)
IGOR_MOUNT_GROUP=1                            # mount /etc/group inside the container (0/1)
IGOR_MOUNTS_RO="${HOME}/.azure ${HOME}/.kube" # space separated list of volumes to mount read only
IGOR_MOUNTS_RW=''                             # space separated list of volumes to mount read write
IGOR_WORKDIR=${PWD}                           # use this workdir inside the container
IGOR_WORKDIR_MODE=rw                          # mount the workdir with this mode (ro/rw)
IGOR_ENV=''                                   # space separated list of environment variables set inside the container
