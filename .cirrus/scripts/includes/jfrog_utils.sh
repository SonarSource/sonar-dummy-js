#!/bin/bash
set -euo pipefail

function extract_module_names() {
  artifact=$1
  module=$(echo "$artifact" | sed -E "s,^([^/]+/[^/]+/([^/]+))/([^/]+)/(([0-9].)+[0-9]+)/.*$,\1:\3:\4," | sed "s,/,.,g")
  echo "$module"
}

function extract_artifacts() {
  public_artifacts=()
  private_artifacts=()
  artifacts=$(grep Installing | sed 's,.*\.m2/repository/,,')
  while read -r artifact; do
    if [[ $artifact == "org/"* ]]; then
      public_artifacts+=("$artifact")
    elif [[ $artifact == "com/"* ]]; then
      private_artifacts+=("$artifact")
    fi
  done <<<"$artifacts"
}

function upload_artifacts() {
  jfrog config add test --artifactory-url "$ARTIFACTORY_URL" --access-token "$ARTIFACTORY_DEPLOY_PASSWORD"
  pushd "${CIRRUS_WORKING_DIR}/.m2/repository/"
  for artifact in "${public_artifacts[@]}"; do
    echo "Deploying public artifact: $artifact"
    module=$(extract_module_names "$artifact")
    jfrog rt u --module "$module" --build-name "${CIRRUS_REPO_NAME}" --build-number "${BUILD_ID}" "$artifact" "${ARTIFACTORY_DEPLOY_REPO}"
  done

  jfrog config edit test --artifactory-url "$ARTIFACTORY_URL" --access-token "$ARTIFACTORY_PRIVATE_DEPLOY_PASSWORD"
  for artifact in "${private_artifacts[@]}"; do
    echo "Deploying private artifact: $artifact"
    module=$(extract_module_names "$artifact")
    jfrog rt u --module "$module" --build-name "${CIRRUS_REPO_NAME}" --build-number "${BUILD_ID}" "$artifact" "${ARTIFACTORY_PRIVATE_DEPLOY_REPO}"
  done
  popd
}
