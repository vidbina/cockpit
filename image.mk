VERSION_FILE=VERSION
COCKPIT_VERSION = $(shell cat ${VERSION_FILE})
include project.mk
include credentials.mk

# Signature fingerprint to verify kube-aws tarball
# https://coreos.com/kubernetes/docs/latest/kubernetes-on-aws.html
COCKPIT_SIG_KUBE_AWS=18AD 5014 C99E F7E3 BA5F  6CE9 50BD D3E0 FC8A 365E
