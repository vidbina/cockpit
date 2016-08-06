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

Produce a `*details.mk` file in the project's root containing the settings you
need for your cockpit and ensure this file is included in the Makefile. In my
case the `*details.mk` was simply called `details.mk` and is included in the
Makefile by default :wink:.

```Makefile
COCKPIT_OWNER=vidbina
COCKPIT_PROJECT=cockpit
COCKPIT_VERSION=v0.1.0-alpha.2
COCKPIT_AWS_PROFILE=X
COCKPIT_AWS_ACCESS_KEY_ID=XXXXXXXXXXXXXXXXXXXX
COCKPIT_AWS_SECRET_ACCESS_KEY=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
COCKPIT_AWS_DEFAULT_REGION=X
```

## Usage

The following commands are meant to be used after completing the setup as
described in the previous section.

Run `make build` to build the cockpit container.
Run `make list` to list all cockpit containers.
Run `make clean` to remove all cockpit containers.
Run `make shell` to connect to the cockpit.
