#
# Haproxy Dockerfile for Raspberry Pi
#
# https://github.com/hypriot/haproxy


# Pull base image.
FROM resin/rpi-raspbian:latest

# Enable Jessie backports
RUN echo "deb http://httpredir.debian.org/debian jessie-backports main" >> /etc/apt/sources.list

# Setup GPG keys
RUN gpg --keyserver pgpkeys.mit.edu --recv-key  8B48AD6246925553 \     
    && gpg -a --export 8B48AD6246925553 | sudo apt-key add - \
    && gpg --keyserver pgpkeys.mit.edu --recv-key  7638D0442B90D010 \  
    && gpg -a --export 7638D0442B90D010 | sudo apt-key add -

# Install HAProxy      
RUN apt-get update \
	&& apt-get install haproxy -t jessie-backports

# Define working directory.
WORKDIR /usr/local/etc/haproxy/

# Copy config file to container
COPY haproxy.cfg .
COPY start.bash .

# Define mountable directories.
VOLUME ["/haproxy-override"]

# Run loadbalancer
# CMD ["haproxy", "-f", "/usr/local/etc/haproxy/haproxy.cfg"]

# Define default command.
CMD ["bash", "start.bash"]

# Expose ports.
EXPOSE 80
EXPOSE 443



