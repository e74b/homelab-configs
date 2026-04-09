# miniton
mini anton -> miniton

personal homelab config files

## deploying

Create an inventory.ini
```ini
[miniton]
root.host.goes.here
```
I use almalinux 10 as my root host, any rhel based distro should work though

```bash
ansible-galaxy collection install community.general
ansible-playbook playbook.yml -i inventory.ini
```

A persistent directory is expected to be present at /data. It stores keys, tokens, and bind mounts, essentially anything that shouldn't be comitted. The ansible playbook does not not cover setting up this directory, so you're on your own here

