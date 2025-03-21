#!/usr/bin/env bash

# IPTABLE configuration for ALL USERS
# Allow loopback traffic (localhost)
iptables -A OUTPUT -o lo -j ACCEPT
iptables -A INPUT -i lo -j ACCEPT

# Allow UDP for openVPN connection
sudo iptables -A INPUT -p udp --dport 1194 -j ACCEPT

# Allow SSH (port 22) for remote connections
iptables -A OUTPUT -m owner --uid-owner analyst -p tcp --dport 22 -j ACCEPT

# Allow HTTP (port 80) and HTTPS (port 443) for web browsing
iptables -A OUTPUT -m owner --uid-owner analyst -p tcp --dport 80 -j ACCEPT
iptables -A OUTPUT -m owner --uid-owner analyst -p tcp --dport 443 -j ACCEPT

# Allow DNS (port 53) for name resolution
iptables -A OUTPUT -m owner --uid-owner analyst -p udp --dport 53 -j ACCEPT
iptables -A OUTPUT -p tcp --dport 53 -j ACCEPT

# Allows using Network Time Protocol
iptables -A OUTPUT -p udp --dport 123 -j ACCEPT

#HUNTER configuration
# Radare2 web interface
iptables -A OUTPUT -p tcp --dport 8000 -m owner --uid-owner hunter -j ACCEPT

# Ghidra server mode
iptables -A OUTPUT -p tcp --dport 13100 -m owner --uid-owner hunter -j ACCEPT

# Cuckoo Web interface
iptables -A OUTPUT -p tcp --dport 2042 -m owner --uid-owner hunter -j ACCEPT

# Cuckoo VM management
iptables -A OUTPUT -p tcp --dport 5900 -m owner --uid-owner hunter -j ACCEPT

# Cuckoo server-worker communication
iptables -A OUTPUT -p tcp --dport 10001 -m owner --uid-owner hunter -j ACCEPT

# SURICATA default ports
iptables -A OUTPUT -p tcp --dport 31337 -m owner --uid-owner hunter -j ACCEPT

# FRIDA default ports
iptables -A OUTPUT -p tcp --dport 27042 -m owner --uid-owner hunter -j ACCEPT

# Block all other outgoing and incoming traffic
iptables -A OUTPUT -m owner --uid-owner hunter -j DROP

#ANALYST configuration is the base configuration, with the rest of the ports closed.
#OwlArch will have all ports open for ease of administration tasks.

# Block all other outgoing and incoming traffic
iptables -A OUTPUT -m owner --uid-owner analyst -j DROP

#enabling persistency after boot
iptables-save > /etc/iptables/iptables.rules
systemctl enable iptables
echo "[+] IPTABLE setup performed."
