#! /bin/sh

# ---------------------------------------------------------------------------- #
# Build crun from sources because it's not provided as a Ubuntu package yet.   #
# github.com/containers/crun#build                                             #
# ---------------------------------------------------------------------------- #
echo [$(date -u)]
echo Starting to build crun...

apt-get update -qq

apt-get install -qq -y make git gcc build-essential pkgconf libtool \
    libsystemd-dev libcap-dev libseccomp-dev libyajl-dev go-md2man libtool \
    autoconf python3 automake

CURRENT_FOLDER=$(pwd)

cd ~
git clone https://github.com/containers/crun.git

cd crun
./autogen.sh
./configure
make
make install

cd $CURRENT_FOLDER

echo [$(date -u)]
echo DONE!
echo ============================================================

# ---------------------------------------------------------------------------- #
# Install fuse-overlayfs & podman, and set up crun as the default OCI runtime  #
# for root Podman.                                                             #
#                                                                              #
# References:                                                                  #
# github.com/containers/libpod/blob/master/docs/tutorials/rootless_tutorial.md #
# podman.io/blogs/2019/10/29/podman-crun-f31.html                              #
# ---------------------------------------------------------------------------- #
echo [$(date -u)]
echo Starting Podman setup...

apt-get install -qq -y ca-certificates curl gnupg

. /etc/os-release
echo "deb https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_${VERSION_ID}/ /" > /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list
curl -L https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_${VERSION_ID}/Release.key | apt-key add -

apt-get update -qq
apt-get install -qq -y fuse-overlayfs podman

sed -i s/'^runtime = "runc"'/'runtime = "crun"'/ /usr/share/containers/libpod.conf

echo [$(date -u)]
echo DONE!
echo ============================================================
