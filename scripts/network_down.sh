#!/usr/bin/bash

iptables -D FORWARD -i wg0 -j ACCEPT
iptables -D FORWARD -o wg0 -j ACCEPT
iptables -t nat -D POSTROUTING -s 10.8.0.1/24 -o eth0 -j MASQUERADE

ip link delete dev wg0 type wireguard
