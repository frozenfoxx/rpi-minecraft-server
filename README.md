# rpi-minecraft-server
[Minecraft Server](https://minecraft.net/en-us/download/server) for [Docker](https://www.docker.com) on the [Raspberry Pi](https://www.raspberrypi.org).

Docker Hub: [https://hub.docker.com/r/frozenfoxx/rpi-minecraft-server/](https://hub.docker.com/r/frozenfoxx/rpi-minecraft-server/)

# How to Build
```
git clone git@github.com:frozenfoxx/rpi-minecraft-server.git
cd rpi-minecraft-server
docker build .
```

# How to Use this Image
## Quickstart
The following will set up, install, and run the latest Minecraft server.  This is fine for testing but not ideal for long term.

```
docker run -d --name=minecraft_server \
  -p 25565:25565 \
  -v /srv \
  -e EULA=true \
  -e DEFAULT_OP=[name] \
  frozenfoxx/rpi-minecraft-server
```

## Data Container
To persist your world data, plugins, and other information you're going to want to create a data container (or otherwise mount storage).  The following will quickly create one:

```
docker create -v /srv --name minecraft_data frozenfoxx/rpi-minecraft-server /bin/true
```

You can then mount this container using `--volumes-from`:

```
docker run -d --name=minecraft_server \
  -p 25565:25565 \
  --volumes-from minecraft_data \
  -e EULA=true \
  -e DEFAULT_OP=[name] \
  frozenfoxx/rpi-minecraft-server
```

## Docker Compose
You can also adjust and deploy the server via the `docker-compose.yml` as such:

```
docker-compose up -d minecraft
```

# Configuration
## Environment Variables
This image can be configured using environment variables.  The following are the most common used.

* `EULA`: required by Mojang.
* `DEFAULT_OP`: required when creating a new container. Any usernames specified will be added to the `ops.json` file.
* `JAVA_OPS`: JVM options.
* `MINECRAFT_HOME`: home of the Minecraft server (default: `/srv`)
* `MOTD`: message of the day.
* `LEVEL_NAME`: world to load.
* `LEVEL_SEED`: world seed.
* `DIFFICULTY`: difficulty of the world.
* `GAMEMODE`: game type to load.
* `PVP`: whether to allow Player vs Player combat.

# Notes
* Accepting the [Mojang EULA](https://account.mojang.com/documents/minecraft_eula) is absolutely required to use this image.  By setting the environment variable `EULA` you are signifying your agreement.
