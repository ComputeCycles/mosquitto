FROM arm64v8/ubuntu
MAINTAINER Van Simmons <van.simmons@computecycles.com>

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update
RUN apt-get -y install apt-utils openssl libwebsockets-dev libcjson-dev
RUN groupadd -r mosquitto && useradd --no-log-init -r -g mosquitto mosquitto

COPY mosquitto.conf /etc/mosquitto.conf
COPY src/mosquitto /usr/sbin/mosquitto

VOLUME ["/var/lib/mosquitto"]

EXPOSE 1883 3000

ADD docker-entrypoint.sh /usr/bin/

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["/usr/sbin/mosquitto", "-c", "/etc/mosquitto.conf"]
