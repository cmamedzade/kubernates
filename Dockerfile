FROM ubuntu:latest

# Install Java11
ENV SBT_VERSION 1.3.13
RUN  apt-get update \
  && apt-get install -y wget \
  && rm -rf /var/lib/apt/lists/*
RUN apt-get update && apt-get install -y software-properties-common

RUN add-apt-repository ppa:openjdk-r/ppa
RUN apt-get update 
RUN apt install -y openjdk-11-jdk
# Install Scala and SBT
RUN apt-get update && apt-get install -y gnupg2

RUN echo "deb https://dl.bintray.com/sbt/debian /" | tee -a /etc/apt/sources.list.d/sbt.list
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 642AC823
RUN apt-get update
RUN apt-get install sbt -y
RUN mkdir -p /scala
ADD classicToTyped.tar.xz /scala
WORKDIR  /scala/classicToTyped

# Exposing port 80
EXPOSE 80

CMD sbt run             # we can override it: docker run ubuntu sleep 5.
# OR
ENTRYPOINT [ "sleep","10" ]  # we can override it: docker run ubuntu 5. 