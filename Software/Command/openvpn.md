Docker compose and configuration
=====
* https://github.com/kylemanna/docker-openvpn/blob/master/docs/docker-compose.md
```yaml
version: '3'
services:
  openvpn:
    cap_add:
     - NET_ADMIN
    image: kylemanna/openvpn
    container_name: openvpn
    ports:
     - "1194:1194/udp"
    restart: always
    volumes:
      - /home/vpn/openvpn:/etc/openvpn
```

Usage
=====
```bash
# Enter once
# duplicate-cn means allowing multiple connection for a user.ovpn file
docker-compose -f ./openvpn/docker-compose.yml run --rm openvpn ovpn_genconfig -e 'duplicate-cn' -u udp://vpn.sevenone.online

# Enter once
docker-compose -f ./openvpn/docker-compose.yml run --rm openvpn ovpn_initpki # enter same password for all questions

# Main server start
docker-compose -f ./openvpn/docker-compose.yml up -d --build
sudo chown -R $(whoami):$(whoami) /home/$(whoami)/

# Enter once
docker-compose run --rm openvpn easyrsa build-client-full $CLIENTNAME nopass # Create vpn user without password
docker-compose run --rm openvpn ovpn_getclient $CLIENTNAME > $CLIENTNAME.ovpn # Dump vpn file

# Enter once
docker-compose run --rm openvpn ovpn_revokeclient $CLIENTNAME remove # Remove user

```

Troubleshooting
=====
* Unable to connect to vpn on macOS
    * Disable ipv6

