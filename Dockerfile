# stage: build code
FROM iamccc/alpine-node:16.20 AS NODE_IMAGE
WORKDIR /app
COPY . .
#RUN ls -l ./backend/node_modules |wc -l

RUN export MELODY_IN_DOCKER=1 && npm run init && rm -rf frontend

# stage: copy
FROM iamccc/alpine-node:16.20
WORKDIR /app

COPY --from=pldin601/static-ffmpeg:22.04.061404-87ac0d7 /ffmpeg /ffprobe /usr/local/bin/

COPY --from=NODE_IMAGE /app/ .

EXPOSE 5566

CMD ["node", "backend/src/index.js"]
