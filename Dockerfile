ARG JAVA_IMAGE_VERSION=17
ARG COMMAFEED_VERSION=2.6.0

FROM eclipse-temurin:${JAVA_IMAGE_VERSION}-jre
ARG JAVA_IMAGE_VERSION
ARG COMMAFEED_VERSION

RUN mkdir -p /home/commafeed/log && \
    curl --fail --location --silent \
    https://github.com/Athou/commafeed/releases/download/$COMMAFEED_VERSION/commafeed.jar \
    -o /home/commafeed/commafeed.jar && \
    curl --fail --location --silent \
    https://raw.githubusercontent.com/Athou/commafeed/$COMMAFEED_VERSION/config.yml.example \
    -o /home/commafeed/config.yml

RUN chown -R 1000:1000 /home/commafeed && \
    chown root /home/commafeed/commafeed.jar && \
    chmod a-w /home/commafeed/commafeed.jar

USER 1000

WORKDIR /home/commafeed

EXPOSE 8082
EXPOSE 8084

ENTRYPOINT [ "/usr/bin/env", "java", "-Djava.net.preferIPv4Stack=true", "-jar", "/home/commafeed/commafeed.jar" ]
CMD [ "server", "/home/commafeed/config.yml" ]

LABEL org.opencontainers.image.title Commafeed RSS Reader $COMMAFEED_VERSION running on java $JAVA_IMAGE_VERSION
LABEL org.opencontainers.image.source https://github.com/jkrafczyk/commafeed-docker
LABEL org.opencontainers.image.version $COMMAFEED_VERSION

# TODO: Health probes