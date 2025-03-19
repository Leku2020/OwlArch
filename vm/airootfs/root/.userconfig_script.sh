#!/usr/bin/env bash

# Configuration of ACL's
setfacl -m g:basicGroup:r-- /usr/bin/tools
setfacl -m g:reversingGroup:rx /usr/bin/tools/reversing
setfacl -m g:netsecGroup:rx /usr/bin/tools/netsec
setfacl -m g:osintGroup:rx /usr/bin/tools/osint
setfacl -m g:malwareGroup:rx /usr/bin/tools/malware
echo "[+] ALC setup completed successfully."

# Configuration of the IPTABLE rules
#blocking output and input internet connections
iptables -A OUTPUT -m owner --gid-owner reversingGroup -j REJECT
iptables -A INPUT -m owner --gid-owner reversingGroup -j REJECT
#allowing 127.0.0.1 localhost as some tools have optional tasks with it
iptables -A OUTPUT -m owner --gid-owner reversingGroup -d 127.0.0.1 -j ACCEPT

# Configuration of basicGroup
# Allow loopback traffic (localhost)
iptables -A OUTPUT -m owner --uid-owner analyst -o lo -j ACCEPT
iptables -A INPUT -m owner --uid-owner analyst -i lo -j ACCEPT

# Allow SSH (port 22) for remote connections
iptables -A OUTPUT -m owner --uid-owner analyst -p tcp --dport 22 -j ACCEPT
iptables -A INPUT -m owner --uid-owner analyst -p tcp --sport 22 -j ACCEPT

# Allow HTTP (port 80) and HTTPS (port 443) for web browsing
iptables -A OUTPUT -m owner --uid-owner analyst -p tcp --dport 80 -j ACCEPT
iptables -A OUTPUT -m owner --uid-owner analyst -p tcp --dport 443 -j ACCEPT
iptables -A INPUT -m owner --uid-owner analyst -p tcp --sport 80 -j ACCEPT
iptables -A INPUT -m owner --uid-owner analyst -p tcp --sport 443 -j ACCEPT

# Allow DNS (port 53) for name resolution
iptables -A OUTPUT -m owner --uid-owner analyst -p udp --dport 53 -j ACCEPT
iptables -A OUTPUT -m owner --uid-owner analyst -p tcp --dport 53 -j ACCEPT

# Block all other outgoing traffic
iptables -A OUTPUT -m owner --uid-owner analyst -j DROP

# Block all other incoming traffic
iptables -A INPUT -m owner --uid-owner analyst -j DROP

#enabling persistency after boot
iptables-save > /etc/iptables/iptables.rules
systemctl enable iptables
echo "[+] IPTABLE setup performed."
