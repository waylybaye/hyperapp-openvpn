FROM kylemanna/openvpn

MAINTAINER HyperApp <hyperappcloud@gmail.com>

ENV DEBUG 0
ENV DOMAIN=
ENV CLIENT_NAME HyperAppOVPN
ENV EASYRSA_BATCH true
ENV EASYRSA_REQ_CN $DOMAIN

COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["ovpn_run"]
