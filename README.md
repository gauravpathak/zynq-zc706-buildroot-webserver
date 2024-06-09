# zynq-zc706-buildroot-webserver
Building and Running zynq-zc706 Image using QEMU inside Docker

# Task
Create a script that builds a Linux system using Buildroot 2023.08.3. The system should be targeted towards the Xilinx ZC706 evaluation board 
and host an HTTP server with a website at port 80.

Verify that the image works by booting it using QEMU. Create a docker file that reproduces the OS build and
QEMU boot.

The docker file should clone the buildroot repository and build the linux system based on
a custom defconfig. Upon running, the docker image should present a shell prompt in the system booted via QEMU.

You can forward the port from the QEMU target to the Docker image port to inspect the QEMU-hosted website in your browser, 
or verify that the website is correctly configured with wget.

Solving the task should result in a Dockerfile along with supplementary files required to build/boot
the target system image.
>----------------------------------------------------
# Instructions
## Building and Booting Buildroot Zynq-ZC706 Image using Docker

The steps have been tested and verified on Ubuntu 22.04.3 LTS; however, they should run on any Linux platform.

## Prerequisites
- Any Linux distribution with Docker installed. Refer to https://docs.docker.com/engine/install/ to install the Docker engine on the distro you are currently running
- At least 15GB of free disk space; Buildroot's build output itself is approximately 13GB
- Port 80 on host machine should be free; please ensure that no other application is listening on port 80. Refer: https://www.cyberciti.biz/faq/unix-linux-check-if-port-is-in-use-command/

## Steps for Building the Image
- Extract **Docker-Build.tar.gz**: `tar -xvf Docker-Build.tar.gz`
- Go to the extracted Directory: `cd Docker-Build`
- The directory structure should look something like this:   
  Docker-Build  
  ├── build.sh  
  ├── Dockerfile  
  ├── run-qemu.sh  
  └── zc706_qemu_webserver_defconfig  
      -- **build.sh**: Shell script that takes care of building and running the Docker container image  
      -- **Dockerfile**: Recipe for building and booting the Zynq-ZC706 inside the container  
      -- **run-qemu.sh**: Shell script with QEMU command for booting the image (used in the Dockerfile)  
      -- **zc706_qemu_webserver_defconfig**: Customized Buildroot config file for ZC706 target  
- Execute the shell script **build.sh**: `sh build.sh`  
> Sit back, relax, or grab a coffee; the build should take somewhere around 1 hour to 1 hour 30 minutes. Depending on the internet speed and host machine configuration, the build time can be less.
- After the build finishes, the script will start the docker container with port 80 of container mapped to port 80 of the host machine
- The container executes/calls **run-qemu.sh**, which boots the Zynq-ZC706 image and drops to the login shell of the booted image
- Wait for 60 seconds for the services to initialize
- Open web browser on your host machine, type localhost or ip address of the ethernet interface of your host machine in the address bar; hit enter
- Nginx welcome page should appear on the browser 
