#!/usr/bin/env bash

# Configuration of ACL's
echo “[+] Setting up ACL rules for groups…”
setfacl -m g:basicGroup:r-- /usr/bin/tools
setfacl -m g:forensicGroup:rx /usr/bin/tools/forensic
setfacl -m g:netsecGroup:rx /usr/bin/tools/netsec
setfacl -m g:osintGroup:rx /usr/bin/tools/osint
setfacl -m g:binexpGroup:rx /usr/bin/tools/binexp
echo "[+] ALC setup completed successfully."

# Configuration of the IPTABLE rules
echo “[+] Setting up IPTABLE rules for groups…”
#blocking output and input internet connections
iptables -A OUTPUT -m owner --gid-owner forensicGroup -j REJECT
iptables -A INPUT -m owner --gid-owner forensicGroup -j REJECT
#allowing 127.0.0.1 localhost as some tools have optional tasks with it
iptables -A OUTPUT -m owner --gid-owner forensicGroup -d 127.0.0.1 -j ACCEPT
#enabling persistency after boot
iptables-save > /etc/iptables/iptables.rules
systemctl enable iptables
echo "[+] IPTABLE setup completed succesfully."