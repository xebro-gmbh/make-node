FROM node:22-bookworm AS base

ENV USER_GID 1000
ENV USER_UID 1000
ENV HISTFILE /var/www/html/.bash_history
ENV WORKING_DIR="/var/www/html"

RUN apt-get update -q && \
    apt-get install -y gosu sudo vim && \
    apt-get autoremove -y && \
    apt-get clean -y

COPY ./etc/entrypoint.sh /docker-entrypoint.d/entrypoint.sh
RUN chmod +x /docker-entrypoint.d/entrypoint.sh
RUN echo "%sudo ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

ENTRYPOINT ["/docker-entrypoint.d/entrypoint.sh"]

WORKDIR ${WORKING_DIR}

EXPOSE 3000

FROM base AS dev

