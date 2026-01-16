FROM alpine:latest

# Installiere OpenJDK 25
RUN apk add --no-cache openjdk25

# Setze Umgebungsvariablen
ENV JAVA_HOME=/usr/lib/jvm/java-25-openjdk
ENV PATH="${JAVA_HOME}/bin:${PATH}"

# Verifiziere die Installation
RUN java -version

WORKDIR /app

CMD ["sh"]
