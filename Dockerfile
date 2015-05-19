FROM ubuntu:trusty
MAINTAINER DU MINH TAM <duminhtam@gmail.com>

RUN apt-get update \
 && apt-get install -y redis-server \
 && rm -rf /var/lib/apt/lists/* # 20150504

RUN sed 's/^daemonize yes/daemonize no/' -i /etc/redis/redis.conf \
 && sed 's/^bind 127.0.0.1/bind 0.0.0.0/' -i /etc/redis/redis.conf \
 && sed 's/^# unixsocket /unixsocket /' -i /etc/redis/redis.conf \
 && sed 's/^# unixsocketperm 755/unixsocketperm 777/' -i /etc/redis/redis.conf \
 && sed '/^logfile/d' -i /etc/redis/redis.conf

ADD run.sh /run.sh
RUN chmod 755 /run.sh

EXPOSE 6379

VOLUME ["/var/lib/redis"]
VOLUME ["/run/redis"]
CMD ["/run.sh"]
