FROM debian:9

ENV SKYSCRAPER_VERSION=3.5.5

WORKDIR /src
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
      build-essential \
      qt5-default \
      wget \
  && \
  wget https://github.com/muldjord/skyscraper/archive/${SKYSCRAPER_VERSION}.tar.gz && \
  tar xvzf ${SKYSCRAPER_VERSION}.tar.gz && \
  cd skyscraper-${SKYSCRAPER_VERSION} && \
  qmake && \
  make && \
  make install && \
  rm -rf /src && \
  apt-get -y purge \
    build-essential \
    wget \
    $(dpkg -l|grep -- -dev |awk '{print $2}'|grep ^lib|awk -F: '{print $1}' ) && \
  apt-get clean all && \
  rm -rf /usr/share/doc/* && \
  rm -rf /usr/share/info/* && \
  rm -rf /tmp/* && \
  rm -rf /var/tmp/* && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /src && \
  mkdir /src && \
  rm -rf /usr/local/include/boost && \
  rm -rf /usr/local/lib/libboost* && \
  rm -rf /usr/local/lib/cmake

WORKDIR /
