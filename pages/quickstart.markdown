---
layout: home
title: Quick Start Guide
permalink: /quickstart
---

# OwlArch Dsitribution Quick Start Guide  
**OSINT & Malware Analysis Toolkit**  

OwlArch is an Arch Linux-based distribution designed for all user types in the cybersecurity and investigations fields. Therefore, in order to help less technically experienced users, as well as advanced users who need to get started fast, a guide is documented with the basic steps to download and configure the machine. The process takes no longer than 5 minutes!

---

## There are 5 main steps to setup the environment.

## 1. Downloading the distribution
Download the distribution via the following link: [Latest Release](https://github.com/Leku2020/OwlArch/releases)
Once downloaded, you should have a zipped ISO file, extract it and step 1 is complete!

## 2. Creating a virtual machine
For most use cases, the ISO can be used to create a new virtual machine. Download your favourite virtualisation software, such as VirtualBox or VMWare, and create a new machine.
At this point, select the ISO to be used for this new machine, and set at least 4GB of ram and 12GB Storage to ensure a stable performance.

## 3. Launch the machine, log in and change credentials
By default, the machines users have a preset password (the same as their name), and so it is IMPORTANT to change credentials.
For this step, it is recommended to use the owlarch user to log in, to escalate privileges and change all of the users passwords at once. This can be done executing the following commands:
```bash  
   sudo su 
   ``` 
And once in sudo mode, copy and paste the following command, replacing "newpassword" with the desired one:
A minimum of 12 characters, mixture of lower and upper case letters, digits and symbols should be used to maximise security.
```bash  
   echo "analyst:newpassword” | sudo chpasswd
   echo "hunter:newpassword" | sudo chpasswd
   echo "owlarch:newpassword" | sudo chpasswd
   echo "root:newpassword" | sudo chpasswd
   ```
## 4. Execute the brave configuration script
Brave browser comes preinstalled for all users. This browser is preinstalled due to its major security advantages and capabilities. However, bookmarks need to be set per user, so to save end users time, a script was created to assign the most common OSINT tools to the bookmarks. Simply execute the following command on the chosen user (ANALYST OR HUNTER) and brave will be configured.
```bash  
   echo "analyst:newpassword” | sudo chpasswd
   ```
## 5. Familiarise yourself with the tools.

The preinstalled tools are listed below:

| Category                | Tools                                                                  |  
|-------------------------|-----------------------------------------------------------------------|  
| **Reverse Engineering** | Ghidra, Radare2, Capstone, Binary Ninja (optional)                    |  
| **Malware Analysis**    | Volatility, Pwndbg, Cuckoo Sandbox (integration)                      |  
| **Network Analysis**    | Wireshark, Suricata, Zeek, TCPDump, OpenVPN, ProxyChains-NG           |  
| **OSINT**               | Maltego, Spiderfoot, theHarvester, Shodan CLI, OwlSearch              |  
| **Debugging**           | GDB, Frida, QEMU                                                      |  

For more info on how they work, simply press [here](packages)

AND DONE! You are ready to start investigating. Happy Hunting!

---

## Other useful documentation
## Documentation  
- **About**: [About](about)  
- **Build Process**: [ISO Pipeline](https://github.com/Leku2020/OwlArch/blob/main/.github/workflows/BuildISO.yml)
- **Build Process**: [Pages Pipeline](https://github.com/Leku2020/OwlArch/blob/main/.github/workflows/PublishPages.yml)
- **Build Process**: [Pages Documentation](actionspages)
- **Tool Docs**: [Package Repository](https://leku2020.github.io/OwlArchRepo)  
- **Create you repo**: [Your repo Documentation](yourownrepo)

---

## Community & Support  
- **Discussions**: [GitHub Forum](https://github.com/Leku2020/OwlArch/discussions)  
- **Contributing**: [Guide](https://leku2020.github.io/OwlArch/contribute)  
- **Bugs/Requests**: [Issue Tracker](https://github.com/Leku2020/OwlArch/issues) 

---

**OwlArch** - Where Arch Linux meets digital forensics 🦉🔍  
