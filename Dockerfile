FROM debian:bookworm-slim

# Set environment variables
ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL="C.UTF-8" LANG="en_US.UTF-8" LANGUAGE="en_US.UTF-8"
ENV PUID=1000 PGID=1000

ENV VERSION=0.9.2

# Install packages
RUN sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list.d/debian.sources && \
    apt-get update -qq  && \
	apt-get install --no-install-recommends -qy apt-utils wget tzdata ca-certificates unzip openssl && \
	apt-get clean -qy && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN sed -i 's/mirrors.ustc.edu.cn/deb.debian.org/g' /etc/apt/sources.list.d/debian.sources

# Add user
RUN groupadd -g $PGID spotconn
RUN useradd -u $PUID -g $PGID -G audio -d /config -m spotconn

# Download binary
RUN cd /tmp && wget https://github.com/philippe44/SpotConnect/releases/download/$VERSION/SpotConnect-$VERSION.zip && \
    unzip SpotConnect-$VERSION.zip && cp spotupnp-linux-x86_64* /usr/bin && chmod 0755 /usr/bin/spotupnp-linux-x86_64* && \
    rm -rf /tmp/*

USER spotconn
WORKDIR /config

CMD ["spotupnp-linux-x86_64", "-Z"]
