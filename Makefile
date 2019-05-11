
ARANGODB_VERSION=3.4.4
IMAGE_VERSION=${ARANGODB_VERSION}-r0
IMAGE_NAME=chrisgarrett/arangodb
RUN_ARGS=--rm -it \
	-v `pwd`/data:/work/data \
	-v cg_arangodb:/var/lib/arangodb3 \
	-p 8529:8529 \
	-e ARANGO_ROOT_PASSWORD=somepassword \
	${IMAGE_NAME}:${IMAGE_VERSION}

.PHONEY: all prep build run bash

all: build

prep:
	ARANGODB_VERSION=${ARANGODB_VERSION} \
	IMAGE_VERSION=${IMAGE_VERSION} \
	IMAGE_NAME=${IMAGE_NAME} \
	envsubst '$${ARANGODB_VERSION} $${IMAGE_VERSION} $${IMAGE_NAME}' < ./templates/Dockerfile.template > Dockerfile && \
	envsubst '$${ARANGODB_VERSION} $${IMAGE_VERSION} $${IMAGE_NAME}' < ./templates/README.md.template > README.md

build: prep
	docker build --no-cache --rm=true -t ${IMAGE_NAME}:${IMAGE_VERSION} .

run:
	docker run ${RUN_ARGS}

bash:
	docker run ${RUN_ARGS} bash
