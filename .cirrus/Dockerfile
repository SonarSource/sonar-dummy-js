ARG CIRRUS_AWS_ACCOUNT
FROM ${CIRRUS_AWS_ACCOUNT}.dkr.ecr.eu-central-1.amazonaws.com/base:j21-latest

USER root

RUN apt-get update && apt-get install --no-install-recommends -y nodejs=18.* \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

USER sonarsource
