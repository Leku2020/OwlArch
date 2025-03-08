---
layout: actions
title: Actions ISO
permalink: /actionsiso
---

[🔙 Go back home](/OwlArch/)

# GitHub Actions Pipeline for OwlArch ISO Builds

## Overview  
This workflow automates the generation and deployment of OwlArch ISO images using GitHub Actions. It handles dependency installation, containerized builds, artifact management, and release automation for the Arch Linux-based distribution tailored for malware analysis and OSINT.

---

## Workflow Triggers  
- On every push to:  
  - `main` branch  
  - Branches matching `feature/**` pattern  
- Manual execution via GitHub UI (`workflow_dispatch`)

---

## Jobs Breakdown  
### 1. `build-ova`  
Handles the complete ISO build process in an Arch Linux container.  

**Steps:**  
- **Checkout code**  
  Fetches repository contents using `actions/checkout@v3`.  

- **Containerized Build**  
  Runs in `archlinux:latest` Docker container:  
  ```bash  
  # System update & dependencies  
  sudo pacman -Syu --noconfirm  
  sudo pacman -S --noconfirm archiso arch-install-scripts [...] qemu shellcheck python-docutils  

  # Workspace setup  
  mkdir $GITHUB_WORKSPACE/work  
  mkdir $GITHUB_WORKSPACE/out  

  # ISO generation  
  sudo mkarchiso -v -w $GITHUB_WORKSPACE/work -o $GITHUB_WORKSPACE/out  
  ```  

- **Artifact Upload**  
  Stores ISO artifact (`owlArchIso`) using `actions/upload-artifact@v3`.  

- **Release Automation**  
  Creates GitHub Release on `main` branch pushes using `softprops/action-gh-release@v1`:  
  - Attaches ISO artifact  
  - Uses `GITHUB_TOKEN` for authentication  

---

## Technical Specifications  
- **Base Image**: Official Arch Linux container  
- **Build Tools**:  
  - `mkarchiso` (ISO builder)  
  - `arch-install-scripts` (System configuration)  
  - QEMU/OVMF (Virtualization support)  
- **Workspace Structure**:  
  ```  
  $GITHUB_WORKSPACE/  
  ├── work/    # Temporary build directory  
  └── out/     # Final ISO output location  
  ```  

---

## Artifact Management  
- **ISO Artifact**:  
  - Name: `owlArchIso`  
  - Retention: 90 days (GitHub default)  
  - Pattern: `$GITHUB_WORKSPACE/out/*.iso`  

---

## Release Process  
- **Conditions**: Only triggers on `main` branch pushes  
- **Components**:  
  - Tagged release version  
  - Attached ISO artifact  
  - Automatic changelog from commit history  

---

## Infrastructure Requirements  
- **Runner**: GitHub-hosted `ubuntu-latest`  
- **Container Resources**: Inherits host specs (2-core CPU/7GB RAM typical)  
- **Network**: Full internet access for dependency resolution  

---

## Security Considerations  
- Uses official Arch Linux container to ensure build consistency  
- Explicit dependency declaration in `pacman -S` command  
- Artifact upload restricted to authenticated releases  
- Forensic-ready tools pre-installed in ISO (e.g., Volatility, Ghidra)  

---

## Maintenance Notes  
- To **update build tools**: Modify the `pacman -S` command in Docker step  
- To **modify ISO contents**: Adjust files in repository's `releng/` directory  
- To **change output format**: Update `mkarchiso` parameters  

This workflow ensures reproducible, secure builds of OwlArch for malware analysis and OSINT operations.  