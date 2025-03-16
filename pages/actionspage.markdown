---
layout: actions
title: Actions Pages
permalink: /actionspages
---

[🔙 Go back home](/OwlArch/)

# GitHub Actions Workflow for Publishing GitHub Pages

This document provides an overview of a GitHub Actions workflow designed to automate the deployment of a Jekyll-based static site to GitHub Pages. The workflow is triggered by specific events and includes two main jobs: `build_pages` and `deploy`.

---

## Workflow Triggers

The workflow is triggered under the following conditions:

1. **Push Events**:
   - Activates when changes are pushed to the `main` branch.
   - Only triggers if changes are made within the `pages/**` directory.

2. **Manual Trigger (`workflow_dispatch`)**:
   - Allows manual execution of the workflow via the GitHub UI.

---

## Jobs in the Workflow

### 1. Build Pages Job (`build_pages`)

#### Conditions:
- Runs only if the trigger is from the `main` branch (`github.ref == 'refs/heads/main'`).

#### Environment:
- Runs on: `ubuntu-latest`.

#### Steps:
1. **Checkout Repository**:
   - Uses the `actions/checkout@v4` action to clone the repository into the workspace.

2. **Setup Pages**:
   - Configures the environment for GitHub Pages using `actions/configure-pages@v5`.

3. **Install Ruby and Bundler**:
   - Sets up Ruby version `3.0` and installs Bundler with caching enabled using `ruby/setup-ruby@v1`.

4. **Install Dependencies**:
   - Navigates to the `pages` directory and installs dependencies using `bundle install`.

5. **Build with Jekyll**:
   - Builds the Jekyll site using `actions/jekyll-build-pages@v1`.
   - Specifies the source directory (`./pages`) and the destination directory (`./output_dir`).

6. **Upload Artifact**:
   - Uploads the built site (located in `./output_dir`) as a GitHub artifact named `deploy_artifact` using `actions/upload-pages-artifact@v3`.

---

### 2. Deployment Job (`deploy`)

#### Conditions:
- Runs only if the trigger is from the `main` branch (`github.ref == 'refs/heads/main'`).
- Depends on the successful completion of the `build_pages` job.

#### Permissions:
- Grants the necessary permissions for deploying to GitHub Pages:
  - `contents: read`
  - `pages: write`
  - `id-token: write`

#### Environment:
- Specifies the `github-pages` environment.
- Sets the URL of the deployed site to `${{ steps.deployment.outputs.page_url }}`.

#### Steps:
1. **Deploy to GitHub Pages**:
   - Deploys the previously uploaded artifact (`deploy_artifact`) to GitHub Pages using `actions/deploy-pages@v4`.

---

## Key Features

1. **Selective Triggering**:
   - The workflow ensures that it only runs when relevant changes are made (e.g., within the `pages/**` directory).

2. **Dependency Management**:
   - Uses Bundler to manage and cache dependencies, ensuring efficient builds.

3. **Artifact Sharing**:
   - The `build_pages` job generates an artifact (`deploy_artifact`) that is shared with the `deploy` job for publishing.

4. **Environment Configuration**:
   - Configures the `github-pages` environment with appropriate permissions and outputs the deployed site's URL.

---

## Example Use Case

This workflow is ideal for automating the deployment of Jekyll-based static sites to GitHub Pages. By separating the build and deployment processes into distinct jobs, it ensures modularity and reusability while maintaining clarity in the workflow structure.

---
