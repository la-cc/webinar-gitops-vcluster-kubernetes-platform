# Webinar Templater

> **_NOTE:_** you can build the templater locally with `docker build . -f build/docker/Dockerfile -t webinar-templater:0.0.0`.

This is simple tool to create a blueprint from a template. The tool is based on `jinja2` and `yaml` and can be used to create a blueprint from a template. You can use this the webinar templater to bootstrap your platform project.

## 1. Igor

We will use the `igor`.
The tool opens a shell in your favorite docker container mounting your current workspace into the container.

The following steps are executed:

- Start the image
- Mount necessary directories
- Set permissions
- Clean up

To install `igor` just download the `igor.sh` and store it in your `$PATH` like this:

    sudo curl https://raw.githubusercontent.com/la-cc/igor/main/igor.sh -o /usr/local/bin/igor
    sudo chmod +x /usr/local/bin/igor

### Configure igor

Running `igor` without configuration will launch a busybox image. In order to use the tool ,
a configuration file is required.

> **_NOTE:_** You can get the recent tag from this repository.

Open the file `.igor.sh` in your preferred editor and use the following settings to configure `igor`:


    # select docker image
    IGOR_DOCKER_IMAGE=webinar-templater:0.0.0
    IGOR_DOCKER_COMMAND=                                  # run this command inside the docker container
    IGOR_DOCKER_PULL=0                                    # force pulling the image before starting the container (0/1)
    IGOR_DOCKER_RM=1                                      # remove container on exit (0/1)
    IGOR_DOCKER_TTY=1                                     # open an interactive tty (0/1)
    IGOR_DOCKER_USER=$(id -u)                             # run commands inside the container with this user
    IGOR_DOCKER_GROUP=$(id -g)                            # run commands inside the container with this group
    IGOR_DOCKER_ARGS=''                                   # default arguments to docker run
    IGOR_PORTS=''                                         # space separated list of ports to expose
    IGOR_MOUNT_PASSWD=1                                   # mount /etc/passwd inside the container (0/1)
    IGOR_MOUNT_GROUP=1                                    # mount /etc/group inside the container (0/1)
    IGOR_MOUNTS_RO="${HOME}/.azure"                       # space separated list of volumes to mount read only
    IGOR_MOUNTS_RW=''                                     # space separated list of volumes to mount read write
    IGOR_WORKDIR=${PWD}                                   # use this workdir inside the container
    IGOR_WORKDIR_MODE=rw                                  # mount the workdir with this mode (ro/rw)
    IGOR_ENV=''                                           # space separated list of environment variables set inside the container



## 2. Workflow


The following steps are executed:

Part I:

1. The user executes the `igor` command to start the container with the `webinar-templater` image and mounts the current directory.
2. The user executes the `config-init` command to create a configuration file.
3. The user modifies the configuration file.

Part II:

1. The user executes the `igor` command to start the container with the `webinar-templater` image and mounts the current directory.
2. The user executes the `config-template --all` command to create a blueprint from the templates.
3. This command generate manifests and resources like `Application`, `Secret`, `main.tf`and overlays for Agro CD, vCluster, etc.


## 3. Configuration Options


The following examples show the possible configuration of the templating. The used module itself can be further adjusted or overwritten.

```yaml
clusters:
  - name: <project-name>
    ssoGroup: <
    nodePools:
      - name: "ppol-infra"
        availability_zones: ["eu01-2"]
        machine_type: "c1.2"
        maximum: 2
        minimum: 1
        os_version_min: "4081.2.0"
        labels:
          project: "infrastructure"
        taints:
          - key: "infrastructure"
            value: "true"
            effect: "NoSchedule"
```

## 4. Usage

- Watch the webinar to see the setup in action. -> [Watch the Webinar](https://www.youtube.com/watch?v=7p1GdyS7kmA)!

- Read the Blog to get an better understanding. -> [How to Build a Multi-Tenancy Internal Developer Platform with GitOps and vCluster](https://itnext.io/how-to-build-a-multi-tenancy-internal-developer-platform-with-gitops-and-vcluster-d8f43bfb9c3d)