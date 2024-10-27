FROM node:23-alpine

RUN apk add --update --no-cache openssl git && rm -rf /var/cache/apk/*
RUN npm install -g pnpm

COPY --chmod=755 ./docker-entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]