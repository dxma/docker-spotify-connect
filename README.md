# Docker Spotify Connect

docker image for philippe44/SpotConnect

## Background

This is a proxy application to bridge your DLNA/UPNP client with Spotify Connect.
In my own use case, I bridge Spotify Plus on mobile phone to DLNA speakers.

## Configuration

Docker compose example:

```yaml
version: "2.1"
services:
  lms-upnp-bridge:
    image: dxma/spotify-connect:0.9.2
    container_name: spotify-connect
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Asia/Shanghai
    volumes:
      - /Application/spotify-connect:/config
    restart: unless-stopped

    network_mode: host
```

Note host network mode is required.

More configuration consult [here](https://github.com/philippe44/SpotConnect).

## Debug

Start the docker container yourself, like this:

```bash
docker run -it --rm -e TZ=Asia/Shanghai --network=host -v /Application/spotify-connect:/config dxma/spotify-connect:0.9.2 bash
# spotupnp-linux-x86_64 <args>
```

## Bugs

The latest version 0.9.2 segfaults on generating default config file.
Have to pass all options via command line parameters.
