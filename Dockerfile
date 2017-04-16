FROM kylemanna/openvpn

MAINTAINER HyperApp <hyperappcloud@gmail.com>

ENV DOMAIN=
ENV CLIENT_NAME HyperApp
ENV EASYRSA_BATCH true
ENV EASYRSA_REQ_CN $DOMAIN

ENTRYPOINT ['docker-entrypoint.sh']
