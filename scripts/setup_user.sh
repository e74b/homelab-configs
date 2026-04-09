#!/usr/bin/bash
# setup_user.sh
# run by ansible to ensure that necessary users and permissions exist.
# WARNING: THIS SCRIPT IS RUN AS A PRIVILEGED USER


id unprivileged
if [ "$?" -ne "0" ]; then
  echo "user does not exist. creating."
  useradd unprivileged
fi;

mkdir -p /data
chown unprivileged /data

# not sure if this is needed
# loginctl enable-linger unprivileged

mv /miniton/services/*.service /etc/systemd/system/
systemctl daemon-reload

