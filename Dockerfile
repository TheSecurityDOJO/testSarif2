FROM node:lts-alpine

ADD docker-entrypoint.sh /home/node/docker-entrypoint.sh

RUN chown node:node /home/node/docker-entrypoint.sh && \
    chmod ug+x /home/node/docker-entrypoint.sh

RUN mkdir /home/node/app

ADD ./public /home/node/app/public
ADD ./views /home/node/app/views
COPY ./.env /home/node/app/
COPY ./server.js /home/node/app/
COPY ./package.json /home/node/app/
COPY ./package-lock.json /home/node/app/

RUN chown -R node:node /home/node/app/

WORKDIR /home/node/app

USER node

EXPOSE 3000

ENTRYPOINT ./../docker-entrypoint.sh