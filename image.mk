VERSION_FILE=VERSION
COCKPIT_VERSION = $(shell cat ${VERSION_FILE})
include project.mk
include credentials.mk
