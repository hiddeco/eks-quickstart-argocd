#!/usr/bin/env bash

set -eo pipefail

ARGO_VERSION=$1
ROOT_DIR=$(git rev-parse --show-toplevel)
CRD_FILE="$ROOT_DIR/argocd/crds.yaml"

if [[ -z "$ARGO_VERSION" ]]; then
    echo "version parameter required"
    exit 1
fi

curl -Isf "https://github.com/argoproj/argo-cd/releases/tag/$ARGO_VERSION" > /dev/null
if [[ $? -ne 0 ]]; then
    echo "non existing version"
    exit 1
fi

echo -n "" > ${CRD_FILE}
declare -a crds=("application-crd.yaml" "appproject-crd.yaml")
for c in "${crds[@]}"
do
    echo "Downloading $c"
    echo "---" >> ${CRD_FILE}
    curl -fsS "https://raw.githubusercontent.com/argoproj/argo-cd/$ARGO_VERSION/manifests/crds/$c" >> ${CRD_FILE}
done
