# Este script es para automatizar pusheos a Git

#!/usr/bin/env bash


DEST="$(dirname "$(realpath "$0")")"

cd "$DEST"
git add .
git commit -S -m "Actualización de archivos $(date +"%Y-%m-%d %H:%M:%S")"
git push origin main
