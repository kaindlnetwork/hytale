FROM eclipse-temurin:25-jre-alpine

# Compatible with LinuxServer
WORKDIR /config

RUN apk add --no-cache curl p7zip dos2unix netcat-openbsd

# Download and extract Hytale Downloader
RUN curl -L -o hytale.zip https://downloader.hytale.com/hytale-downloader.zip

COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

# Healthcheck - prüft nur ob Port 5520 erreichbar ist
HEALTHCHECK --interval=30s --timeout=10s --start-period=120s --retries=3 \
    CMD nc -z 127.0.0.1 5520 || exit 1

# Tini
RUN apk add --no-cache tini
# Tini is now available at /sbin/tini
ENTRYPOINT ["/sbin/tini", "/app/entrypoint.sh"]
