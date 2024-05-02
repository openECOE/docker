#!/bin/bash

set -eu

# Valores predeterminados
REPO="openecoe/one-for-all"
RELEASE="$(date '+%Y-%m-%d')"
API_VERSION="latest"
WEBUI_VERSION="latest"
ADDITIONAL_TAGS=()

# Analizar las opciones y argumentos con nombre
while getopts "r:R:t:a:w:" opt; do
  case $opt in
    r)
      REPO="$OPTARG"
      ;;
    R)
      RELEASE="$OPTARG"
      ;;
    t)
      ADDITIONAL_TAGS+=("$OPTARG")
      ;;
    a)
      API_VERSION="$OPTARG"
      ;;
    w)
      WEBUI_VERSION="$OPTARG"
      ;;
    *)
      echo "Uso: $0 [-r repo] [-R release] [-a versionAPI] [-w versionWEBUI] [-t additional_tag]..."
      exit 1
      ;;
  esac
done

# Construir la imagen de Docker
docker build -t "$REPO:$RELEASE" --build-arg API_VERSION=$API_VERSION --build-arg WEBUI_VERSION=$WEBUI_VERSION .

# Etiquetar la imagen de Docker
for tag in "${ADDITIONAL_TAGS[@]}"; do
  docker tag "$REPO:$RELEASE" "$REPO:$tag"
done
 
