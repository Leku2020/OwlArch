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
- **Automated Builds**: Daily ISO updates via GitHub Actions  
- **Privacy-First**: Brave browser, DNS-over-HTTPS, and hardened kernel configs  
- **Virtualization Ready**: OVF/VMDK templates for VMware/VirtualBox  
- **Customizable**: Easily add/remove tools via the [OwlArch Package Repository](https://github.com/Leku2020/owlArchRepo)  

---
## Automated Build Process  
OwlArch uses **GitHub Actions** for continuous integration and delivery:  
- **Daily ISO Builds**: Automated generation of bootable ISO images  
- **Containerized Workflow**: Secure, reproducible builds using Arch Linux Docker images  
- **Artifact Management**: ISOs uploaded to GitHub Releases for easy access  
- **Testing**: Built-in validation for package integrity and tool functionality  

[View the full GitHub Actions pipeline →](https://github.com/Leku2020/owlArchRepo/blob/main/.github/workflows/build-ova.yml)  

And for more info press [here](actionsiso)

---

## Tools Included

| Category               | Tools                                                                 |  
|------------------------|-----------------------------------------------------------------------|  
| **Reverse Engineering** | Ghidra, Radare2, Capstone, Binary Ninja (optional)                    |  
| **Malware Analysis**    | Volatility, Pwndbg, Cuckoo Sandbox (integration)                      |  
| **Network Analysis**    | Wireshark, Suricata, Zeek, TCPDump                                    |  
| **OSINT**               | Maltego, Spiderfoot, theHarvester, Shodan CLI                         |  
| **Debugging**           | GDB, Frida, QEMU                                                      |  

For more info press [here](packages)

---

## Quick Start  
1. **Download ISO**:  
   [Latest Release](https://github.com/Leku2020/owlArchRepo/releases) | [SHA256 Checksum](https://leku2020.github.io/OwlArch/checksums.txt)  

2. **Run Tools**:  
   ```bash  
   wireshark  # Launch network analyzer  
   volatility -f memdump.dmp imageinfo  # Memory forensics example  
   ```  

---

## Documentation  
- **User Guide**: [OwlArch Documentation](https://leku2020.github.io/OwlArch)  
- **Build Process**: [ISO Pipeline](https://github.com/Leku2020/owlArchRepo/blob/main/.github/workflows/build-ova.yml)  
- **Tool Docs**: [Package Repository](https://leku2020.github.io/owlArchRepo)  

---

## Community & Support  
- **Discussions**: [GitHub Forum](https://github.com/Leku2020/OwlArch/discussions)  
- **Contributing**: [Guide](https://leku2020.github.io/OwlArch/contribute)  
- **Bugs/Requests**: [Issue Tracker](https://github.com/Leku2020/OwlArch/issues) 

---

**OwlArch** - Where Arch Linux meets digital forensics 🦉🔍  