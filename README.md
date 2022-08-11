# Commafeed-docker

A docker image for running the excellent [Commafeed](https://github.com/Athou/commafeed) RSS reader

## Quick start

```
docker run --rm -p8082:8082 ghcr.io/jkrafczyk/commafeed-docker:2.6.0
```

## Configuration

By default, the image uses the [example config file](https://raw.githubusercontent.com/Athou/commafeed/$COMMAFEED_VERSION/config.yml.example), except that data is written to /tmp instead of /home/commafeed.

To modify the configuration, provide a custom config file and mount it to the path /config/config.yaml:
```
docker run --rm -p8082:8082 -v/path/to/my/config.file:/config/config.yaml ghcr.io/jkrafczyk/commafeed-docker:2.6.0
```