FROM ubuntu:16.04

LABEL MAINTAINER Jedsada Tiwongvorakul <pondthaitay@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
ENV JAVA_HOME       /usr/lib/jvm/java-8-oracle

# Install Java 8
RUN apt-get update && \
  apt-get install -y --no-install-recommends locales && \
  locale-gen en_US.UTF-8 && \
  apt-get dist-upgrade -y && \
  apt-get --purge remove openjdk* && \
  echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections && \
  echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" > /etc/apt/sources.list.d/webupd8team-java-trusty.list && \
  apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886 && \
  apt-get update && \
  apt-get install -y --no-install-recommends oracle-java8-installer oracle-java8-set-default && \
  apt-get clean all

# Install Ruby Gem
RUN apt-get install -y ruby-dev

# Install Make
RUN apt-get install -y make

# Install Gradle
RUN apt-get update && apt-get -y install gradle && gradle -v

# Install Maven 2
RUN apt-get purge maven maven2 && apt-get update && apt-get -y install maven && mvn --version

# Install Fatlane
RUN gem install fastlane --no-document && fastlane --version

# Cleaning
RUN apt-get clean
