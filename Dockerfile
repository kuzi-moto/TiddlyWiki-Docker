FROM node:14-alpine3.12

ARG TW_VERSION=5.1.21

VOLUME [ "/wiki" ]

ENV TW_HOST=0.0.0.0
ENV TW_PATH_PREFIX=
ENV TW_USERNAME=
ENV TW_PASSWORD=
ENV TW_AUTHENTICATED_USER_HEADER=
ENV TW_READERS=
ENV TW_WRITERS=
ENV TW_DEBUG_LEVEL=none

RUN npm install -g tiddlywiki@${TW_VERSION}
COPY ["tiddlywiki.info", "/wiki"]

EXPOSE 8080

CMD tiddlywiki /wiki --listen \
  host=${TW_HOST} \
  path-prefix=${TW_PATH_PREFIX} \
  port=${TW_PORT} \
  username=${TW_USERNAME} \
  password=${TW_PASSWORD} \
  authenticated-user-header=${TW_AUTHENTICATED_USER_HEADER} \
  readers=${TW_READERS} \
  writers=${TW_WRITERS} \
  debug-level=${TW_DEBUG_LEVEL}