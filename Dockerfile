FROM arm32v7/debian
MAINTAINER Van Simmons <van.simmons@computecycles.com>

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update
RUN apt-get -y install apt-utils openssl libwebsockets8 
RUN groupadd -r mosquitto && useradd --no-log-init -r -g mosquitto mosquitto
RUN mkdir -p /mqtt/config /mqtt/data /mqtt/log
RUN chown -R mosquitto.mosquitto /mqtt

COPY mosquitto.conf /mqtt/config
COPY src/mosquitto /usr/sbin/mosquitto

VOLUME ["/mqtt/config", "/mqtt/data", "/mqtt/log"]

EXPOSE 1883 3000

ADD docker-entrypoint.sh /usr/bin/

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["/usr/sbin/mosquitto", "-c", "/mqtt/config/mosquitto.conf"]
