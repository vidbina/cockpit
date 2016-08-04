###############################################################################
# This Makefile assists in creating the cockpit which is utilized to control
# the cluster. The cockpit contains all the tools necessary to execute commands
# such as managing and monitoring clusters.
#
# Run `make build` to build the cockpit container
# Run `make list` to list all cockpit containers
# Run `make clean` to remove all cockpit containers

DOCKER=docker
OWNER=vidbina
PROJ=cockpit
VERSION=v0.1-alpha

LIST_IMG_CMD=docker images -f "label=owner=${OWNER}" -f "label=project=${PROJ}" -a
LIST_IMG_IDS_CMD=${LIST_IMG_CMD} -q

build: Dockerfile
	${DOCKER} build -t "${OWNER}/${PROJ}:${VERSION}" --label "owner=${OWNER}" --label "project=${PROJ}" --force-rm . 

# TODO: Test
clean:
	$(eval IMAGES=$(shell ${LIST_IMG_IDS_CMD}))
	if [ -n "${IMAGES}" ]; then echo ${DOCKER} rmi ${IMAGES}; \
	else echo ${MSG_NO_IMG}; \
	fi

list:
	$(LIST_IMG_CMD)

.PHONY: build clean list
