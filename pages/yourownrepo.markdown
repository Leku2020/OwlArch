---
layout: contribute
title: Your Own Repo
permalink: /yourownrepo
---

[🔙 Go back home](/OwlArch/)

# How to Create Your Own Repository from This Template

This guide will walk you through the process of creating your own repository based on this one. By following these steps, you can customize and adapt this project to suit your needs.

There are two ways described below, we recommend the first one:

---
# How to Create Your Own Repository from This Template

This guide explains how to create your own repository by forking this one. Specifically, you'll fork the `yourOwnRepo` branch, which is designed as a starting point for customizing and building your own project.

---

# First way (Recommended):

## Step-by-Step Instructions

### 1. Fork the Repository
1. Navigate to the [original repository](https://github.com/Leku2020/OwlArch).
2. Click the **Fork** button in the top-right corner of the page.
3. If prompted, select your GitHub account as the destination for the fork.

### 2. Switch to the `yourOwnRepo` Branch
After forking the repository:
1. Open the forked repository on your GitHub account.
2. Use the branch dropdown menu (default branch is usually `main`) and select the `yourOwnRepo` branch.
3. Click the **Branch actions** button (the three dots next to the branch name) and choose **Rename branch** if you want to give it a custom name for your project.

### 3. Clone the Forked Repository
To begin working locally:
1. Copy the repository's URL from the **Code** button on your forked repository.
2. Open a terminal and run the following command:
   ```bash
   git clone https://github.com/<your-username>/<repository-name>.git
   ```
   Replace `<your-username>` and `<repository-name>` with your GitHub username and the forked repository name.
3. Navigate into the cloned directory:
   ```bash
   cd <repository-name>
   ```

### 4. Customize the Repository
The `yourOwnRepo` branch contains a template structure that you can customize for your project:
1. Update the `README.md` file to describe your project.
2. Modify the configuration files (e.g., `.github/workflows/*.yml`) to suit your needs.
3. Add or remove files and directories as necessary.

### 5. Push Changes to Your Repository
Once you've made your changes:
1. Stage your changes:
   ```bash
   git add .
   ```
2. Commit your changes with a meaningful message:
   ```bash
   git commit -m "Initial customization of the repository"
   ```
3. Push your changes to your forked repository:
   ```bash
   git push origin yourOwnRepo
   ```

## Step 6: Enable GitHub Pages (Optional)

If your project includes documentation or a static site, you can enable GitHub Pages to host it:

1. Go to your repository on GitHub.
2. Navigate to **Settings > Pages**.
3. Under **Source**, select GitHub Actions.
4. Save the settings.
5. Edit the .markdown files inside pages folder
6. Run the pages action for GitHub to deploy your site.

Once deployed, your site will be available at `https://YOUR_USERNAME.github.io/The name you give`.

### 7. Publish Releases (Optional)
If your project involves building artifacts (e.g., ISOs):
1. Use the existing GitHub Actions workflows to automate builds and releases.
2. Navigate to the **Actions** tab in your repository to monitor workflow runs.
3. Once a build is complete, publish the artifact to the **Releases** section.

---

## Key Notes

- **Customization**: The `yourOwnRepo` branch is intentionally minimal to provide flexibility. Feel free to adapt it to your specific use case.
- **GitHub Actions**: The workflows provided in this repository are reusable and can be modified to fit your project's requirements.
- **Documentation**: Keep your `README.md` and other documentation up-to-date to help others understand and contribute to your project.

---

# Second way:

## Step 1: Fork the Repository

1. Navigate to the [original repository](https://github.com/Leku2020/OwlArch).
2. Click the **Fork** button in the top-right corner of the page.
3. Select your GitHub account or organization where you want to create the fork.

> **Note**: Forking creates a copy of the repository under your account while maintaining a connection to the original repository for future updates.

---

## Step 2: Clone the Forked Repository

Once you've forked the repository, clone it to your local machine using the following commands:

```bash
git clone https://github.com/YOUR_USERNAME/OwlArch.git
cd OwlArch
```

Replace `YOUR_USERNAME` with your actual GitHub username.

---

## Step 3: Customize the Repository

### 1. Update Metadata
- Open the `README.md` file and update the project name, description, and any other relevant details to reflect your new project.
- Update the `LICENSE` file if necessary to match your licensing preferences.

### 2. Modify Content
- Replace existing content (e.g., documentation, scripts, or workflows) with your own files.
- Adjust the GitHub Actions workflows (`.github/workflows/*.yml`) to fit your project's requirements.

### 3. Update Links
- Update any links in the documentation or README to point to your forked repository instead of the original one.

---

## Step 4: Push Changes to Your Repository

After making your changes, commit and push them to your forked repository:

```bash
git add .
git commit -m "Customize repository for my project"
git push origin main
```

---

## Step 5: Enable GitHub Pages (Optional)

If your project includes documentation or a static site, you can enable GitHub Pages to host it:

1. Go to your repository on GitHub.
2. Navigate to **Settings > Pages**.
3. Under **Source**, select GitHub Actions.
4. Save the settings.
5. Edit the .markdown files inside pages folder
6. Run the pages action for GitHub to deploy your site.

Once deployed, your site will be available at `https://YOUR_USERNAME.github.io/The name you give`.

---

## Step 6: Keep Your Repository Updated (Optional)

To keep your forked repository up-to-date with changes from the original repository:

1. Add the original repository as a remote:
   ```bash
   git remote add upstream https://github.com/Leku2020/OwlArch.git
   ```

2. Fetch updates from the original repository:
   ```bash
   git fetch upstream
   ```

3. Merge changes into your `main` branch:
   ```bash
   git merge upstream/main
   ```

4. Resolve any conflicts and push the updated code to your fork:
   ```bash
   git push origin main
   ```

---

## Example Use Case

By following this guide, you can use this repository as a starting point for your own Arch Linux ISO build pipeline or Jekyll-based documentation site. Customize the workflows, scripts, and content to align with your project goals.

---

For further assistance, refer to the [GitHub Documentation](https://docs.github.com/) or reach out to the community.
