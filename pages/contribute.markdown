---
layout: contribute
title: Contribute
permalink: /contribute
---

[🔙 Go back home](/OwlArch/)

# Contributing to OwlArch Linux Distribution

Thank you for contributing to OwlArch! This guide helps you contribute to our malware analysis/OSINT-focused Arch Linux distribution. Follow these steps to ensure smooth integration of your changes.

---

## Repository Structure  
```  
.
├── vm/               # ISO build configuration
│   ├── airootfs/         # Base filesystem skeleton
│   ├── packages.x86_64   # Package list for ISO
│   └── profiledef.sh     # Build profile settings
└── ...
```

---

## Adding/Updating Tools  

### 1. **Adding New Security Tools**  
1. Update `vm/packages.x86_64` with package name  
   ```diff
   + ghidra
   + volatility
   ```
2. For AUR packages:  
   - Add `--makepkg-conf` parameter in Docker build step  
   - Ensure dependencies are in official repos or included in the ISO  

### 2. **Customizing Tools**  
- Modify `vm/airootfs/etc/skel/` for default configurations  
- Add post-install scripts in `vm/airootfs/root/customize_airootfs.sh`  

---

## Branching & Pull Requests  

### Branch Strategy  
- `main`: Stable production-ready ISO builds  
- `feature/*`: Experimental changes (automatically tested)  

### PR Requirements  
- [ ] Valid `packages.x86_64` entries  
- [ ] Tested ISO build via Docker  
- [ ] Documentation updated in `docs/`  
- [ ] Security tools verified for malware analysis compatibility  

---

## Testing Locally  

### Full ISO Build Test  
```bash  
# Clone repository  
git clone https://github.com/Leku2020/OwlArch
cd OwlArch

# Run build container  
docker run --rm -v $(pwd):/build -w /build archlinux:latest bash -c "  
  pacman -Syu --noconfirm &&  
  pacman -S --noconfirm archiso &&  
  mkarchiso -v -w /build/work -o /build/out ./vm  
"  

# Test ISO in QEMU  
qemu-system-x86_64 -cdrom out/owlArch-*.iso -m 4G  
```  

### Partial Tests  
1. **Package List Validation**:  
   ```bash  
   pacman -Syu --noconfirm && pacman -S --noconfirm - < relenvmg/packages.x86_64  
   ```  
2. **Configuration Checks**:  
   ```bash  
   shellcheck vm/airootfs/root/customize_airootfs.sh  
   ```  

---

## Common Issues  

### Build Failures  
- **Missing Dependencies**: Ensure all packages in `packages.x86_64` exist in:  
  - Official Arch repos 
  - OwlArch repo 
  - AUR (with proper build instructions)  
- **Filesystem Conflicts**: Check for overlapping files in `airootfs/`  

---

## Deployment Process  

### For ISOs

On `main` branch push:  
1. GitHub Actions builds ISO  

On manual launch:
1. GitHub Actions builds ISO  
2. Uploads artifact to [Releases](https://github.com/Leku2020/OwlArch/releases)  

For Pages:
On `main` branch push:  
1. Updates documentation at [OwlArch Docs](https://leku2020.github.io/OwlArch)  

---

## Getting Help  

- **Build Logs**: [GitHub Actions](https://github.com/Leku2020/OwlArch/actions)  
- **Community**: [Discussions](https://github.com/Leku2020/OwlArch/discussions)  
- **Examples**:  
  - [Tool Integration](https://github.com/Leku2020/OwlArch/blob/main/vm/packages.x86_64)  
  - [ISO Customization](https://github.com/Leku2020/OwlArch/tree/main/vm/airootfs)  

Help us keep OwlArch sharp for malware analysis and OSINT operations! 🦉🔍  