#!/bin/bash

set -Eeuo pipefail

user=${USERNAME:-myuser}

useradd -u ${USER_UID:-1000} -s /bin/bash -m "${user}"
chown -R "${user}:${user}" "/home/${user}"

if [[ ! -d "${PROJECT_DIR}" ]]; then
  mkdir -p "${PROJECT_DIR}"
  chown "${user}:${user}" "${PROJECT_DIR}"
fi

if [[ -z "${1:-}" ]]; then
  gosu "${user}" remote-dev-server install-plugins "${PLUGINS:-}"
  exec gosu "${user}" remote-dev-server run "${PORT:-}"
fi

exec "$@"
