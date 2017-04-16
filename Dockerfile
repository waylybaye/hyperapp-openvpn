FROM kylemanna/openvpn

MAINTAINER HyperApp <hyperappcloud@gmail.com>

ENV DOMAIN=
ENV CLIENT_NAME HyperApp
ENV EASYRSA_BATCH true
ENV EASYRSA_REQ_CN $DOMAIN

RUN if ! [ -e /etc/openvpn/openvpn.conf ]; then ovpn_genconfig -u udp://$DOMAIN; fi
RUN if ! [ -e /etc/openvpn/pki ]; then ovpn_initpki nopass; fi
RUN if ! [ -e /etc/openvpn/pki/private/$CLIENT_NAME.key ]; then easyrsa build-client-full $CLIENT_NAME nopass > /etc/openvpn/; fi
RUN if ! [ -e /etc/openvpn//$CLIENT_NAME.ovpn ]; then easyrsa ovpn_getclient $CLIENT_NAME > /etc/openvpn/$CLIENT_NAME.ovpn; fi
