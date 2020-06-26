FROM node:14-alpine3.12

ENV HOST=127.0.0.1
EXPOSE 8080
VOLUME [ "/wiki" ]

RUN npm install -g tiddlywiki
COPY ["tiddlywiki.info", "/wiki"]

CMD [ "tiddlywiki", "/wiki", "--listen" ]