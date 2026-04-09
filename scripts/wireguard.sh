#!/usr/bin/bash
# wireguard.sh
# starts up wireguard and configures peers
# WARNING: THIS SCRIPT IS RUN AS A PRIVILEGED USER

runtime_dir=/data

ip link add dev wg0 type wireguard
ip address add dev wg0 10.8.0.1/16 

iptables -I FORWARD 1 -i wg0 -j ACCEPT
iptables -I FORWARD 1 -o wg0 -j ACCEPT
iptables -t nat -I POSTROUTING 1 -s 10.8.0.1/24 -o eth0 -j MASQUERADE

wg set wg0 listen-port 51820 private-key $runtime_dir/privkey

ip link set up dev wg0

cat $runtime_dir/peers.json | jq '.[]' -c | while read -r line; do 
  addr=$(echo $line | jq -r '.address')
  pubkey=$(echo $line | jq -r '.pubkey')
  name=$(echo $line | jq -r '.name')

  wg set wg0 peer $pubkey allowed-ips $addr/32
  echo "configured $addr $name"
done;
