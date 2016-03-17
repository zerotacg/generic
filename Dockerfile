FROM sickp/alpine-nginx
MAINTAINER SteamCache.Net Team <team@steamcache.net>

ENV ORIGINCACHE_VERSION 1
ENV WEBUSER nginx

COPY overlay/ /

RUN	chmod 755 /scripts/*			;\
	mkdir -m 755 -p /data/cache		;\
	mkdir -m 755 -p /data/info		;\
	mkdir -m 755 -p /data/logs		;\
	mkdir -m 755 -p /tmp/nginx/		;\
	chown -R ${WEBUSER}:${WEBUSER} /data/	;\
	mkdir -p /etc/nginx/sites-enabled	;\
	ln -s /etc/nginx/sites-available/origin.conf /etc/nginx/sites-enabled/origin.conf

VOLUME ["/data/logs", "/data/cache", "/var/www"]

EXPOSE 80

WORKDIR /scripts

ENV ORIGINCACHE_IP 0.0.0.0

ENTRYPOINT ["/scripts/bootstrap.sh"]
