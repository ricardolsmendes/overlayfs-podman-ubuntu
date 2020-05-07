# overlayfs-podman-ubuntu

Shell scripts to set up [Podman container runtine](https://podman.io/),
[crun](https://github.com/containers/crun), and OverlayFS in Ubuntu. **Podman**
containers run faster and safer when powered by `overlayfs` and `crun`.

These scripts are intended to set up rootless Podman (most popular way to use
it) and run in a fresh Ubuntu environment (requires Ubuntu >= 20.04, due to
`cgroup v2` support).

## Environment setup

```sh
chmod +x set-up-system.sh set-up-current-user.sh
```

## Set up crun, fuse-overlayfs, and podman

```sh
sudo ./set-up-system.sh

./set-up-current-user.sh
```

## Expected results

```sh
podman info
```

Make sure the output contains something similar to:

```yaml
...
ociRuntime:
  name: crun
  package: Unknown
  path: /usr/local/bin/crun
  version: |-
    crun version 0.13.105-077b
    commit: 077bebbba5fb6ae1ad7a48a53fd4cb8ab559a74e
    spec: 1.0.0
    +SYSTEMD +SELINUX +APPARMOR +CAP +SECCOMP +EBPF +YAJL...
rootless: true
...
store:
  configFile: /home/ubuntu/.config/containers/storage.conf
  graphDriverName: overlay
  graphOptions:
    overlay.mount_program:
      Executable: /usr/bin/fuse-overlayfs
      Package: 'fuse-overlayfs: /usr/bin/fuse-overlayfs'
...
```
