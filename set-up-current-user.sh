#! /bin/sh

# ---------------------------------------------------------------------------- #
# Set up user's libpod.conf.                                                   #
# Please notice this script is setting up only rootless Podman.                #
#                                                                              #
# References:                                                                  #
# github.com/containers/libpod/blob/master/docs/tutorials/rootless_tutorial.md #
# podman.io/blogs/2019/10/29/podman-crun-f31.html                              #
# ---------------------------------------------------------------------------- #
echo [$(date -u)]
echo Starting rootless Podman setup...

mkdir -p ${HOME}/.config/containers/
echo 'runtime = "crun"' >> ${HOME}/.config/containers/libpod.conf

echo [$(date -u)]
echo DONE!
echo ============================================================
