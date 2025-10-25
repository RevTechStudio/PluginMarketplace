---
name: Setup Codespaces Config
description: Set up GitHub Codespaces configuration files for C# (.NET) development environment. Use when initializing Codespaces for a new or existing project.
---

# Codespaces Initial Setup

Set up GitHub Codespaces development environment configuration files.

## Files to be Set Up

1. `.devcontainer/devcontainer.json` - C# (.NET 9.0) dev container configuration
2. `.github/dependabot.yml` - Weekly automatic update configuration for devcontainers
3. `.markdownlint-cli2.jsonc` - Markdownlint rule configuration

## Execution

- [Script](./scripts/setup-codespaces.sh)
- Update file paths in the script to correct file paths before executing
