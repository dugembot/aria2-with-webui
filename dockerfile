FROM node:lts-alpine
LABEL AUTHOR soulteary
WORKDIR /app

RUN apk add --no-cache git && \
    git clone git@github.com:soulteary/webui-aria2 . && \
    apk del git && \
    rm -rf /var/cache/apk/* /tmp/*

RUN yarn

#ADD webui-aria2/ /app

ADD ./patches/configuration.js /app/src/js/services/configuration.js
ADD ./patches/rpc.js /app/src/js/services/rpc/rpc.js

RUN yarn build

RUN yarn add http-proxy
ADD ./patches/node-server.js /app/node-server.js

CMD [ "node", "./node-server.js" ]
