#
# Haproxy Dockerfile for Raspberry Pi
#
# https://github.com/hypriot/haproxy
#
# A fork of
# https://github.com/dockerfile/haproxy
#

# Pull base image.
FROM resin/rpi-raspbian:latest

# Enable Jessie backports
RUN echo "deb http://httpredir.debian.org/debian jessie-backports main" | \
      sed 's/\(.*\)-sloppy \(.*\)/&@\1 \2/' | tr @ '\n' | \
      tee /etc/apt/sources.list.d/backports.list

# Install HAProxy      
RUN apt-get update \
	&& apt-get install haproxy -t jessie-backports

COPY docker-entrypoint.sh /
COPY haproxy.cfg /usr/local/etc/haproxy/haproxy.cfg

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["haproxy", "-f", "/usr/local/etc/haproxy/haproxy.cfg"]

# Expose ports.
EXPOSE 80
EXPOSE 443
