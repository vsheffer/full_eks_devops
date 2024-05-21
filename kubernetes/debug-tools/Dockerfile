FROM  ubuntu:jammy

RUN apt-get update && \
    apt-get install -y \
      curl \
      iputils-ping \
      postgresql-client \
      telnet \
      vim && \
    rm -rf /var/lib/apt/lists/*
