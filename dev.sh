#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

NODE_BIN=""
for d in "$ROOT_DIR"/.tools/node-*-darwin-*/bin; do
  if [[ -d "$d" ]]; then
    NODE_BIN="$d"
    break
  fi
done

if [[ -z "${NODE_BIN}" ]]; then
  echo "Local Node not found under .tools/. First run the setup steps again."
  exit 1
fi

export PATH="$NODE_BIN:$PATH"

cd "$ROOT_DIR/web"
if [[ ! -d node_modules ]]; then
  npm install
fi

npm run dev -- --host 127.0.0.1 --port 5173

