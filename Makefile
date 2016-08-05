###############################################################################
# This Makefile assists in creating the cockpit which is utilized to control
# the cluster. The cockpit contains all the tools necessary to execute commands
# such as managing and monitoring clusters.
#
# Run `make build` to build the cockpit container
# Run `make list` to list all cockpit containers
# Run `make clean` to remove all cockpit containers

SHELL=/bin/sh

DOCKER=docker

# Project settings such as the owner handle, the project name, the cockpit
# image version and other details are stored in a seprate file to be included
# into this Makefile.
include details.mk

LIST_IMG_CMD=${DOCKER} images \
	-f "label=owner=${COCKPIT_OWNER}" -f "label=project=${COCKPIT_PROJECT}" -a
LIST_IMG_IDS_CMD=${LIST_IMG_CMD} -q

build: Dockerfile
	${DOCKER} build \
		-t "${COCKPIT_OWNER}/${COCKPIT_PROJECT}:${COCKPIT_VERSION}" \
		-t "${COCKPIT_OWNER}/${COCKPIT_PROJECT}:latest" \
		--label "owner=${COCKPIT_OWNER}" --label "project=${COCKPIT_PROJECT}" \
		--force-rm .

# TODO: Test
clean:
	$(eval IMAGES=$(shell ${LIST_IMG_IDS_CMD}))
	if [ -n "${IMAGES}" ]; then echo ${DOCKER} rmi ${IMAGES}; \
	else echo ${MSG_NO_IMG}; \
	fi

list:
	$(LIST_IMG_CMD)

ssh:
	${DOCKER} run -it ${COCKPIT_OWNER}/${COCKPIT_PROJECT}:${COCKPIT_VERSION} /bin/sh

.PHONY: build clean list
