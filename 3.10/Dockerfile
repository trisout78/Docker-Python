FROM        --platform=$TARGETOS/$TARGETARCH python:2.7-alpine

RUN         apk add --update --no-cache cmake make ca-certificates curl ffmpeg g++ gcc git openssl sqlite tar tzdata \
				&& adduser -D -h /home/container container

USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

COPY        ./../entrypoint.sh /entrypoint.sh
CMD         [ "/bin/ash", "/entrypoint.sh" ]