FROM        --platform=$TARGETOS/$TARGETARCH python:3.9-alpine

RUN         apk add --update --no-cache cmake make ca-certificates curl ffmpeg g++ gcc git openssl sqlite tar tzdata \
				&& adduser -D -h /home/container container

LABEL 		org.opencontainers.image.source https://github.com/trisout78/Docker-Python
USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

COPY        ./../entrypoint.sh /entrypoint.sh
COPY        --chmod=777 ./start.sh /start.sh
CMD         [ "/bin/ash", "/entrypoint.sh" ]