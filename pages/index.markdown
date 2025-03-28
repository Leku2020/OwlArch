---
layout: home
title: Index
permalink: /
---

# OwlArch Linux Distribution  
**OSINT & Malware Analysis Toolkit**  

OwlArch is an Arch Linux-based distribution designed for **malware analysis**, **reverse engineering**, and **OSINT investigations**. It combines a minimalistic Arch environment with a curated suite of security tools, automated builds, and forensic readiness.  

---

## Key Features  
- **Pre-installed Tools**: Plenty of security tools for malware analysis, network forensics, and OSINT  
- **Automated Builds**: Continious ISO updates via GitHub Actions  
- **Privacy-First**: Brave browser, DNS-over-HTTPS, and hardened kernel configs  
- **Virtualization Ready**: OVF/VMDK templates for VMware/VirtualBox  
- **Customizable**: Easily add/remove tools via the [OwlArch Package Repository](https://github.com/Leku2020/OwlArchRepo)  

---

## Automated Build Process  
OwlArch uses **GitHub Actions** for continuous integration and delivery:  
- **Automated ISO Builds**: Automated generation of bootable ISO images  
- **Containerized Workflow**: Secure, reproducible builds using Arch Linux Docker images  
- **Artifact Management**: ISOs uploaded to GitHub Releases for easy access  
- **Testing**: Built-in validation for package integrity and tool functionality  

[View the full GitHub Actions pipeline →](https://github.com/Leku2020/OwlArch/blob/main/.github/workflows/BuildISO.yml)  

And for more info press [here](actionsiso)

---

## Tools Included

| Category               | Tools                                                                 |  
|------------------------|-----------------------------------------------------------------------|  
| **Reverse Engineering** | Ghidra, Radare2, Capstone, Binary Ninja (optional)                    |  
| **Malware Analysis**    | Volatility, Pwndbg, Cuckoo Sandbox (integration)                      |  
| **Network Analysis**    | Wireshark, Suricata, Zeek, TCPDump                                    |  
| **OSINT**               | Maltego, Spiderfoot, theHarvester, Shodan CLI, OwlSearch              |  
| **Debugging**           | GDB, Frida, QEMU                                                      |  

For more info press [here](packages)

---

## Quick Start  
To read a quickstart guide on how to install and get started, [Click here!](https://leku2020.github.io/OwlArch/quickstart)

---

## Documentation  
- **About**: [About](about)  
- **Build Process**: [ISO Pipeline](https://github.com/Leku2020/OwlArch/blob/main/.github/workflows/BuildISO.yml)
- **Build Process**: [Pages Pipeline](https://github.com/Leku2020/OwlArch/blob/main/.github/workflows/PublishPages.yml)
- **Build Process**: [Pages Documentation](actionspages)
- **Tool Docs**: [Package Repository](https://leku2020.github.io/OwlArchRepo)  
- **Create your distro**: [Your distro Documentation](yourowndistro)

---

## Community & Support  
- **Discussions**: [GitHub Forum](https://github.com/Leku2020/OwlArch/discussions)  
- **Contributing**: [Guide](https://leku2020.github.io/OwlArch/contribute)  
- **Bugs/Requests**: [Issue Tracker](https://github.com/Leku2020/OwlArch/issues) 

---

**OwlArch** - Where Arch Linux meets digital forensics 🦉🔍  
