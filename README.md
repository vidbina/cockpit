# Cockpit

The cockpit is like _The Bridge_ in Star Trek. The central place from which you
control your resources. 

![The Bridge in Start Trek](https://upload.wikimedia.org/wikipedia/en/3/3b/Star_Trek_%28film%29_bridge_panorama_.jpg)

This image was written to provide devops engineers in
the team I work with with a consistent environment from which to manage their
resources (e.g.: the clusters we manage to keep things working).

The cockpit is bundled with the tools necessary to execute Ansible playbooks, 
and to perform aws commands. The idea is that the users of the cockpit will
have all of their needed buttons, handles and levers built into convenient
playbooks.

## Setup

Ensure the `image.mk` file exists in the project's root. The
`image.mk` file includes the `VERSION`, `project.mk` and `credentials.mk`
files.

Within the root of the project a `VERSION` file is expected to contain the tag
of the image to produce. It is recommended to bump this version every time a
change to the Dockerfile is made.

The `project.mk` file should list the owner and project name in the form:

```Makefile
COCKPIT_OWNER = vidbina
COCKPIT_PROJECT = cockpit
```

The `credentials.mk` file should include the `COCKPIT_AWS_ACCESS_KEY_ID`,
`COCKPIT_AWS_SECRET_ACCESS_KEY` and `COCKPIT_AWS_DEFAULT_REGION` environment
variables in the following manner:

```Makefile
COCKPIT_AWS_ACCESS_KEY_ID=XXXXXXXXXXXXXXXXXXXX
COCKPIT_AWS_SECRET_ACCESS_KEY=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
COCKPIT_AWS_DEFAULT_REGION=X
```

The Makefile will start the container and set the [necessary environment
variables for the AWS CLI tool](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html#cli-environment). You could start the direction manually, but remember to set these
environment variables, or setup the required configuration files, if you intent
to use the AWS CLI tool inside the container.

## Usage

The following commands are meant to be used after completing the setup as
described in the previous section.

Run `make build` to build the cockpit container.
Run `make list` to list all cockpit containers.
Run `make clean` to remove all cockpit containers.
Run `make shell` to connect to the cockpit.

## Changelog
- `v0.1.0-alpha` initial version
- `v0.1.0-alpha.1` added `openssl`
- `v0.1.0-alpha.2` added `awscli` (`pip` was added to install `awscli`)
