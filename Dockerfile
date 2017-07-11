FROM arm32v6/openjdk:8-jre-alpine
MAINTAINER FrozenFOXX <siliconfoxx@gmail.com>

ENV MINECRAFT_HOME="/srv" \
    JAVA_OPTS="-server -Xmx496M -Xms496M" \
    VERSION="latest" \
    MOTD="Docker Powered Minecraft on a Raspberry Pi\!" \
    LEVEL_SEED="" \
    LEVEL_NAME="world" \
    LEVEL_TYPE="DEFAULT" \
    PVP="true" \
    DIFFICULTY="2" \
    GAMEMODE="0" \
    MAX_TICK_TIME="-1"

# Install/update packages
RUN apk -U upgrade && \
    apk add jq \
      curl \
      su-exec

# Add scripts
COPY bin/* /srv/
COPY defaults/* /tmp/

# Set exports and data volumes
EXPOSE  25565
VOLUME  [ "/srv" ]
WORKDIR /srv

# Run the server
ENTRYPOINT /srv/minecraft-server
