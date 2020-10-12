FROM node:lts-alpine
LABEL AUTHOR soulteary

ADD package.json /app/package.json
ADD package-lock.json /app/package-lock.json

WORKDIR /app

RUN npm install -g yarn && yarn

#ADD webui-aria2/ /app

ADD ./patches/configuration.js /app/src/js/services/configuration.js
ADD ./patches/rpc.js /app/src/js/services/rpc/rpc.js

RUN yarn build

RUN yarn add http-proxy
ADD ./patches/node-server.js /app/node-server.js

CMD [ "node", "./node-server.js" ]
