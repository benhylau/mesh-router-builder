FROM resin/armv7hf-debian:stretch

ARG DEBIAN_FRONTEND=noninteractive

RUN [ "cross-build-start" ]

# Get tools
RUN { \
  cd /tmp; \
  apt-get update; \
  apt-get install -y build-essential curl git python2.7; \
  ln -s /usr/bin/python2.7 /usr/bin/python; \
  curl -sL https://deb.nodesource.com/setup_7.x | sudo -E bash -; \
  apt-get install -y nodejs; \
}

# Download source and build binary
ENTRYPOINT { \
  mkdir /tmp/cjdns; \
  git clone https://github.com/cjdelisle/cjdns.git -b __TAG__ /tmp/cjdns; \
  cd /tmp/cjdns; \
  git checkout __TAG__; \
  NO_TEST=1 Seccomp_NO=1 ./do; \
}

RUN [ "cross-build-end" ]
