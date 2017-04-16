#!/bin/bash
if [ -z ${DOMAIN+x} ]; then
  echo "[ERROR] Domain is required";
  exit 1
fi

if ! [ -e /etc/openvpn/openvpn.conf ]; then
  echo "Initializing Configuation ..."
  ovpn_genconfig -u udp://$DOMAIN;
fi

if ! [ -d /etc/openvpn/pki ]; then
  echo "Creating certificates ..."
  ovpn_initpki nopass;
fi

if ! [ -e /etc/openvpn/pki/private/$CLIENT_NAME.key ]; then
  echo "Creating clients certificates ..."
  easyrsa build-client-full $CLIENT_NAME nopass;
fi

if ! [ -e /etc/openvpn//$CLIENT_NAME.ovpn ]; then
  echo "Creating clients configuration ..."
  easyrsa ovpn_getclient $CLIENT_NAME > /etc/openvpn/$CLIENT_NAME.ovpn;
fi

exec "$@"
