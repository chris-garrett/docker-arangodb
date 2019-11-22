FROM arangodb:3.5.2
MAINTAINER Chris Garrett (https://github.com/chris-garrett/docker-arangodb)
LABEL description="Arangodb 3.5.2-r0 Development Image"

ENV DOCKERIZE_VERSION=v0.6.1

RUN apk --no-cache add -U \
  && wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
  && tar -C /usr/local/bin -xzvf dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
  && rm dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
  && adduser -s /bin/bash -D sprout \
  && mkdir -p /work/app && chown -R sprout:sprout /work /home/sprout

#USER sprout
WORKDIR /work/app
