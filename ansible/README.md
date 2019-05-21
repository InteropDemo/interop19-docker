## Build and Run your ansible container

- Download the Dockerfile to a directory into your Docker environment.   
- Build the container.

`docker build -t wejensen/ansible .`

- Run your container

`docker run -d -it --name="ansible" wejensen/ansible`

- Enter your container to initiate ntc commands.

`docker exec -it ansible /bin/bash`
