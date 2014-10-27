FROM seif/mono

MAINTAINER Seif Attar <iam@seifattar.net>

RUN apt-get update \
    && apt-get install runit nginx mono-fastcgi-server4 -y --no-install-recommends \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /var/tmp/* /tmp/* \
    && mkdir -p /etc/mono/registry /etc/mono/registry/LocalMachine \
    && ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log

ADD service/ /etc/service/
ADD config/default /etc/nginx/sites-available/
ADD config/fastcgi_params /etc/nginx/

RUN chmod u+x /etc/service/nginx/run \
    && chmod u+x /etc/service/fastcgi-mono/run

EXPOSE 80
