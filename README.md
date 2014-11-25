## MONO Configured with runit Dockerfile

This repository contains Dockerfile for publishing Docker's automated build to the public [Docker Hub Registry](https://registry.hub.docker.com/) with [Runit](http://smarden.org/runit/) as process with id 1 launching [nginx](http://wiki.nginx.org/Main) and [mono-fastcgi-server4](http://www.mono-project.com/docs/web/fastcgi/) as services and supervising them.

> Nginx is exposed from the container on port 80 and the mono-fastcgi-server4 loads the application from /var/www.

### Base docker image

    seif/mono

### Usage

First you need to pull the image:

    docker pull seif/docker-mono-fastcgi-nginx

Then build your project, create a Dockerfile, copy the application to /var/www and start runit:

    FROM seif/docker-mono-fastcgi-nginx
    ADD buildOutput/website /var/www/
    CMD ["/usr/sbin/runit-bootstrap"]

Build your container

    docker build -t my_website .

Run it, forwarding the host's port 8080 to the container's port 80

    docker run --rm -i -t -p 8080:80 my_website

You should now be able to access the site on [your local machine port 8080](http://localhost:8080/)
