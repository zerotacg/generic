FROM vibroaxe/ubuntu-18-nginx:latest
#FROM 1and1internet/ubuntu-18-nginx:latest
MAINTAINER SteamCache.Net Team <team@steamcache.net>

ENV GENERICCACHE_VERSION 2
ENV WEBUSER nginx
ENV CACHE_MEM_SIZE 500m
ENV CACHE_DISK_SIZE 500000m
ENV CACHE_MAX_AGE 3560d
ENV UPSTREAM_DNS 8.8.8.8 8.8.4.4
ENV BEAT_TIME 1h
ENV LOGFILE_RETENTION 3560

COPY overlay/ /

RUN rm /etc/nginx/sites-enabled/*; \
    chmod 754  /var/log/tallylog ; \
    adduser --system --home /var/www/ --no-create-home --shell /bin/false --group --disabled-login ${WEBUSER} ;\
    chmod 755 /scripts/*			;\
	mkdir -m 755 -p /data/cache		;\
	mkdir -m 755 -p /data/info		;\
	mkdir -m 755 -p /data/logs		;\
	mkdir -m 755 -p /tmp/nginx/		;\
	chown -R ${WEBUSER}:${WEBUSER} /data/	;\
	mkdir -p /etc/nginx/sites-enabled	;\
	ln -s /etc/nginx/sites-available/generic.conf /etc/nginx/sites-enabled/generic.conf

VOLUME ["/data/logs", "/data/cache", "/var/www"]

EXPOSE 80

WORKDIR /scripts
