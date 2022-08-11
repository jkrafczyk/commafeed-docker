ARG JAVA_IMAGE_VERSION=17
ARG COMMAFEED_VERSION=2.6.0

FROM eclipse-temurin:${JAVA_IMAGE_VERSION}-jre-alpine
ARG JAVA_IMAGE_VERSION
ARG COMMAFEED_VERSION

RUN apk --no-cache add curl && \
    mkdir -p /app /config && \
    curl --fail --location --silent \
    https://github.com/Athou/commafeed/releases/download/$COMMAFEED_VERSION/commafeed.jar \
    -o /app/commafeed.jar && \
    curl --fail --location --silent \
    https://raw.githubusercontent.com/Athou/commafeed/$COMMAFEED_VERSION/config.yml.example \
    -o /config/config.yaml && \
    sed -Ei 's/\/home\/commafeed\//\/tmp\//g' /config/config.yaml


EXPOSE 8082
EXPOSE 8084

USER 1000
WORKDIR /tmp

ENTRYPOINT [ "/opt/java/openjdk/bin/java", "-Djava.net.preferIPv4Stack=true", "-jar", "/app/commafeed.jar" ]
CMD [ "server", "/config/config.yaml" ]

HEALTHCHECK --interval=5s --start-period=30s --timeout=2s CMD [ "curl", "--fail", "http://127.0.0.1:8084/ping" ]

LABEL org.opencontainers.image.title Commafeed RSS Reader $COMMAFEED_VERSION running on java $JAVA_IMAGE_VERSION
LABEL org.opencontainers.image.source https://github.com/jkrafczyk/commafeed-docker
LABEL org.opencontainers.image.version $COMMAFEED_VERSION