###############################################################################
# This Makefile assists in creating the cockpit which is utilized to control
# the cluster. The cockpit contains all the tools necessary to execute commands
# such as managing and monitoring clusters.
#
# Run `make build` to build the cockpit container
# Run `make list` to list all cockpit containers
# Run `make clean` to remove all cockpit containers
# Run `make shell` to connect to the cockpit

SHELL=/bin/sh

DOCKER=docker

# Project settings such as the owner handle, the project name, the cockpit
# image version and other details are stored in a seprate file to be included
# into this Makefile.
include image.mk

LIST_FILTER=-f "label=owner=${COCKPIT_OWNER}" \
	-f "label=project=${COCKPIT_PROJECT}"
LIST_CONTAINER_CMD=${DOCKER} ps ${LIST_FILTER} -a
LIST_IMG_CMD=${DOCKER} images ${LIST_FILTER} -a

LIST_CONTAINER_IDS_CMD=${LIST_CONTAINER_CMD} -q
LIST_IMG_IDS_CMD=${LIST_IMG_CMD} -q

LIST_IMG_REPTAG_CMD=${LIST_IMG_CMD} --format {{.Repository}}:{{.Tag}}

build: Dockerfile image.mk project.mk
	${DOCKER} build \
		--rm --force-rm \
		-t "${COCKPIT_OWNER}/${COCKPIT_PROJECT}:${COCKPIT_VERSION}" \
		-t "${COCKPIT_OWNER}/${COCKPIT_PROJECT}:latest" \
		--build-arg KUBE_AWS_SIG="${COCKPIT_SIG_KUBE_AWS}" \
		--build-arg KUBE_AWS_KEY="${COCKPIT_KEY_KUBE_AWS}" \
		--label "owner=${COCKPIT_OWNER}" --label "project=${COCKPIT_PROJECT}" \
		.

clean-containers: project.mk
	$(eval CONTAINERS=$(shell ${LIST_CONTAINER_IDS_CMD}))
	if [ -n "${CONTAINERS}" ]; then ${DOCKER} rm ${CONTAINERS}; \
	else echo "No containers to cleanup"; \
	fi

clean-images: project.mk
	$(eval IMAGES=$(shell ${LIST_IMG_REPTAG_CMD}))
	if [ -n "${IMAGES}" ]; then ${DOCKER} rmi ${IMAGES}; \
	else echo "No images to cleanup"; \
	fi

clean: clean-containers clean-images

list: project.mk
	$(LIST_IMG_CMD)

ifneq ($(COCKPIT_VERSION), "") # Use $COCKPIT_VERSION as version, if available
version = $(COCKPIT_VERSION)
else
ifneq ($(VERSION), "") # otherwise use $VERSION
version = $(VERSION)
else # if all fails, use the "latest" version
version = latest
endif
endif
shell: image.mk project.mk credentials.mk
	${DOCKER} run \
		-e "AWS_ACCESS_KEY_ID=${COCKPIT_AWS_ACCESS_KEY_ID}" \
		-e "AWS_SECRET_ACCESS_KEY=${COCKPIT_AWS_SECRET_ACCESS_KEY}" \
		-e "AWS_DEFAULT_REGION=${COCKPIT_AWS_DEFAULT_REGION}" \
		-v ${COCKPIT_WORKDIR}:/infra \
		-it \
		${COCKPIT_OWNER}/${COCKPIT_PROJECT}:$(version) \
		/bin/sh

.PHONY: build clean clean-containers clean-images list shell
