---
layout: actions
title: Actions ISO
permalink: /actionsiso
---

[🔙 Go back home](/OwlArch/)


# GitHub Actions Workflow for Building OwlArch ISO

This document outlines the structure and functionality of a GitHub Actions workflow designed to build an OwlArch ISO. The workflow is triggered by specific events and includes steps to install dependencies, build the ISO, and optionally create a GitHub release.

## Workflow Triggers

The workflow is triggered under the following conditions:

1. **Push Events**:
   - Activates when changes are pushed to the `main` branch or any branch matching the pattern `feature/*`.
   - Only triggers if changes are made within the `vm/**` directory.

2. **Manual Trigger (`workflow_dispatch`)**:
   - Allows manual execution of the workflow via the GitHub UI.
   - Requires an input parameter:
     - **ReleaseName**: A required field with a default value of `V....`.

## Jobs in the Workflow

### 1. Build ISO Job

#### Environment:
- Runs on: `ubuntu-latest`
- Container: Uses the `archlinux:latest` Docker image with `--privileged` mode for elevated permissions.

#### Steps:
1. **Install Dependencies**:
   - Installs necessary packages using `pacman`, including tools like `archiso`, `git`, `squashfs-tools`, and others required for building the ISO.

2. **Checkout Repository**:
   - Uses the `actions/checkout@v4` action to clone the repository into the workspace.

3. **Remove ACLs from Profile**:
   - Removes Access Control Lists (ACLs) from files in the `vm` directory to ensure compatibility during the build process.

4. **Create Work and Out Directories**:
   - Creates two directories:
     - `work`: Temporary workspace for the build process.
     - `out`: Directory where the final ISO will be stored.

5. **Create Symlinks**:
   - Sets up symbolic links for systemd services:
     - Links `vboxservice.service` to enable VirtualBox guest services.
     - Links `gdm.service` as the display manager service.

6. **Build ISO**:
   - Executes the `mkarchiso` command to generate the ISO file using the configuration in the `vm` directory.

7. **Upload ISO Artifact**:
   - Uploads the generated ISO file as a GitHub artifact named `owlArchIso`.

### 2. Release Job

#### Conditions:
- Depends on the successful completion of the `build-ISO` job.
- Only runs if the workflow is manually triggered (`workflow_dispatch`).

#### Steps:
1. **Checkout Code**:
   - Clones the repository again to ensure access to the latest code.

2. **Download ISO Artifact**:
   - Downloads the previously uploaded ISO artifact (`owlArchIso`) into the `./out` directory.

3. **Create GitHub Release**:
   - Uses the `softprops/action-gh-release@v2` action to create a GitHub release.
   - Includes the downloaded ISO file as part of the release.
   - Release details:
     - Tag name: Matches the branch or tag name (`github.ref_name`).
     - Release title: Includes the provided `ReleaseName` input.

## Key Notes

- **Privileged Mode**: The use of `--privileged` ensures that the container has sufficient permissions to perform tasks like mounting filesystems during the ISO build process.
- **Artifact Management**: The workflow ensures that the ISO file is preserved and shared between jobs using GitHub's artifact storage.
- **Manual Releases**: The `release` job is specifically designed for creating releases when the workflow is manually triggered, providing flexibility for versioning and distribution.

## Example Use Case

This workflow is ideal for automating the creation and distribution of custom OwlArch ISOs. By leveraging GitHub Actions, you can streamline the build process and ensure consistent results across different environments.
