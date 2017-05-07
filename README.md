## rpi-haproxy


This repository contains a port of the **Dockerfile** of [Haproxy](http://haproxy.1wt.eu/) for the Raspberry Pi.

Many kudos to the upstream repo https://github.com/dockerfile/haproxy

### Base Docker Image

* resin/rpi-raspbian:wheezy


### Installation

1. Install [Docker](https://www.docker.com/) by downloading the [HypriotOS SD card image](http://blog.hypriot.com/heavily-armed-after-major-upgrade-raspberry-pi-with-docker-1-dot-5-0).

2. Download [automated build](https://registry.hub.docker.com/u/hypriot/rpi-haproxy/) from public [Docker Hub Registry](https://registry.hub.docker.com/): `docker pull hypriot/rpi-haproxy`

   (alternatively, you can build an image from Dockerfile: `docker build -t="hypriot/rpi-haproxy" github.com/hypriot/haproxy`)


### Usage

    docker run -d -p 80:80 hypriot/rpi-haproxy

#### Customizing Haproxy

    docker run -d -p 80:80 -v <override-dir>:/haproxy-override hypriot/rpi-haproxy

where `<override-dir>` is an absolute path of a directory that could contain:

  - `haproxy.cfg`: custom config file (replace `/dev/log` with `127.0.0.1`, and comment out `daemon`)
  - `errors/`: custom error responses

After few seconds, open `http://<host>` to see the haproxy stats page.
