#!/bin/bash

set -Eeuo pipefail

user=${USERNAME:-myuser}

useradd -u ${USER_UID:-1000} -s /bin/bash -m "${user}"
chown -R "${user}:${user}" "/home/${user}"

if [[ ! -d "/project" ]]; then
  mkdir /project
  chown "${user}:${user}" /project
fi

if [[ -z "${1:-}" ]]; then
  gosu "${user}" remote-dev-server install-plugins "${PLUGINS:-}"
  exec gosu "${user}" remote-dev-server run "${PORT:-}"
fi

exec "$@"
