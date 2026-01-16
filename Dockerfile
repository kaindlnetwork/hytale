FROM eclipse-temurin:25-jre-alpine

# Compatible with LinuxServer
WORKDIR /config

RUN apk add --no-cache curl p7zip dos2unix

# Download and extract Hytale Downloader
RUN curl -L -o hytale.zip https://downloader.hytale.com/hytale-downloader.zip

COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh
# Tini
RUN apk add --no-cache tini
# Tini is now available at /sbin/tini
ENTRYPOINT ["/sbin/tini", "/app/entrypoint.sh"]
