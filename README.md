# Intro

This docker image creates an GCC based AVR cross-compiling toolchain including
libc and binutils.

# Usage

Simply run `docker-compose up` to initiate the process. The necessary
repositories will be cloned into the workspace prior to building the toolchain.
With all components built, a tar file is created that contains all tools for
cross-compiling AVR based projects.

The used version of tools can be found in tools/build.sh:

- BINUTILS_VERSION=2_43_1
- GCC_VERSION=12.4.0
- LIBC_VERSION=2_2_1

The docker file has been tested with above versions. Modifying these values may require
updates to the docker image.
