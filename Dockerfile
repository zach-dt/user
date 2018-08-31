FROM golang:1.7

ENV sourcesdir /go/src/github.com/microservices-demo/user/

ENV MONGO_HOST mytestdb:27017
ENV HATEAOS user
ENV USER_DATABASE mongodb

COPY . ${sourcesdir}

# Install GO
RUN go get -v github.com/Masterminds/glide && cd ${sourcesdir} && glide install && go install

# Install Java 7 for jMeter 3.0
ENV LANG C.UTF-8

RUN { \
	echo '#!/bin/sh'; \
	echo 'set -e'; \
	echo; \
	echo 'dirname "$(dirname "$(readlink -f "$(which javac || which java)")")"'; \
    } > /usr/local/bin/docker-java-home \
    && chmod +x /usr/local/bin/docker-java-home

ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64/jre

ENV JAVA_VERSION 7u181
ENV JAVA_DEBIAN_VERSION 7u181-2.6.14-1~deb8u1

RUN set -x \
    && apt-get update \
    && apt-get install -y \
	openjdk-7-jre-headless="$JAVA_DEBIAN_VERSION" \
    && rm -rf /var/lib/apt/lists/* \
    && [ "$JAVA_HOME" = "$(docker-java-home)" ]

RUN echo $JAVA_HOME
RUN java -version

# Install JMeter
RUN wget https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-3.0.tgz
RUN tar -xvzf apache-jmeter-3.0.tgz
RUN rm apache-jmeter-3.0.tgz

RUN mv apache-jmeter-3.0 /jmeter

ENV JMETER_HOME /jmeter

ENV PATH $JMETER_HOME/bin:$PATH

# Set Working DIR
WORKDIR ${sourcesdir}
