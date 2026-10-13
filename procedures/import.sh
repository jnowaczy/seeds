#!/usr/bin/env bash
set -euo pipefail

: "${MONGODB_URI:?Set MONGODB_URI}"

if ! command -v mongoimport >/dev/null; then
  echo "No mongoimport in PATH" >&2
  exit 1
fi

cd "$(dirname "$0")/dumps"

for file in *.dump; do
  collection="${file%.dump}"
  echo "Import: $collection"
  mongoimport --uri "$MONGODB_URI" --collection "$collection" --file "$file" --drop
done
