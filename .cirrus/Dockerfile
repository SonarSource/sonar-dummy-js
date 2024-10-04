ARG CIRRUS_AWS_ACCOUNT
FROM ${CIRRUS_AWS_ACCOUNT}.dkr.ecr.eu-central-1.amazonaws.com/base:j21-latest

USER root

RUN apt-get update && apt-get install --no-install-recommends -y jq nodejs=18.* \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*




# TODO: install it to base images

# sonar-scanner-cli
# renovate: datasource=github-releases depName=SonarSource/sonar-scanner-cli
ENV SONAR_SCANNER_CLI_VERSION=6.1.0.4477

RUN curl -L -O https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-${SONAR_SCANNER_CLI_VERSION}-linux-x64.zip && \
    unzip sonar-scanner-cli-${SONAR_SCANNER_CLI_VERSION}-linux-x64.zip
RUN mv sonar-scanner-${SONAR_SCANNER_CLI_VERSION}-linux-x64 /opt/sonar-scanner-cli && \
    chmod a+x /opt/sonar-scanner-cli/bin/sonar-scanner

# Create a symbolic link to /usr/bin for global access
RUN ln -s /opt/sonar-scanner-cli/bin/sonar-scanner /usr/bin/sonar-scanner


# Debugging step to check if binary and link exist
RUN ls -l /usr/bin/sonar-scanner && ls -l /opt/sonar-scanner-cli/bin/sonar-scanner


USER sonarsource
