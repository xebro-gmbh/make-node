FROM node:18.19.0-bullseye

MAINTAINER Daniel Langemann <daniel@xebro.de>

ARG XEBRO_VERSION

LABEL de.xebro.company="xebro"
LABEL de.xebro.version=$XEBRO_VERSION

ENV USER_GID 1000
ENV USER_UID 1000
ENV HISTFILE /var/www/html/.bash_history
ENV WORKING_DIR="/var/www/html"

RUN apt-get update && \
    apt-get install -y gosu sudo vim && \
    apt-get upgrade -y && \
    apt-get dist-upgrade -y && \
    apt-get autoremove -y && \
    apt-get clean -y

COPY ./etc/entrypoint.sh /docker-entrypoint.d/entrypoint.sh
RUN echo $XEBRO_VERSION > /var/VERSION
RUN echo "%sudo ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

RUN npm install -g @angular/cli

ENTRYPOINT ["/docker-entrypoint.d/entrypoint.sh"]

WORKDIR ${WORKING_DIR}

EXPOSE 8000
