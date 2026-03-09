#!/bin/bash

set -euo pipefail

COUNT="${1:-100}"
PREFIX="${2:-key}"
VALUE_PREFIX="${3:-value}"

for i in $(seq 1 "${COUNT}"); do
  key="${PREFIX}_${i}"
  value="${VALUE_PREFIX}_${i}"
  curl -sS "http://127.0.0.1:8080/set?key=${key}&value=${value}" >/dev/null
done

echo "curl -sS \"http://127.0.0.1:8080/get?key=${PREFIX}_1\""
