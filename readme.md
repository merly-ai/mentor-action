# Merly Mentor Check

![Merly Wizard Dog Icon](https://cdn.prod.website-files.com/670eb2a8c376d5ee29ffbaa9/67313888472820398af63de2_merly%20icon.png)

Runs **MerlyMentor** inside Docker against your repository, turning technical debt into technical strength.

---

## 🔮 What It Does

- ✅ Determine Code Quality  
- ✅ Objective analysis  
- ✅ Turn technical debt into technical strength  
- ✅ Supports 15 programming languages  
- ✅ Works cross-platform (Linux, Windows, macOS)  

---

## 🚀 Quick Start

```yaml
name: CI / Merly Mentor

on:
  push:
    branches: [ main ]
  pull_request:

jobs:
  mentor-scan:
    runs-on: ubuntu-latest
    permissions:
      contents: write

    steps:
      - uses: your-org/merly-mentor-check@v1.0.0
        with:
          mm-key: ${{ secrets.MM_KEY }}
          checkout-code: true
          # path: ./custom-path       # if you’ve checked out elsewhere
          debug: false
```

---

## ⚙️ Inputs

| Input           | Description                                                               | Default                     |
| --------------- | ------------------------------------------------------------------------- | --------------------------- |
| `mm-key`        | Merly API key (store as repo secret `MM_KEY`).                            | _none_                      |
| `checkout-code` | Perform `actions/checkout` internally? (`true` or `false`)                | `true`                      |
| `path`          | Path to your repo on disk (for custom checkouts)                          | `${{ github.workspace }}`   |
| `debug`         | Enable Mentor’s debug & stdout output (`true` or `false`)                 | `false`                     |

---

## 🛠️ How It Works

1. **(Optional)** Checks out your repository  
2. Binds your code into the container at `/repo`  
3. Runs the MerlyMentor Docker image (pinned by SHA) as your runner user to avoid permission issues  
4. Streams analysis results back into your workflow logs  

Example command inside the action:

```bash
docker run --rm \
  --user "$(id -u):$(id -g)" \
  -e REGISTRATION_KEY="${{ inputs.mm-key }}" \
  -e REPO="/repo" \
  -e MM_MODELS_PATH="/data/.models/" \
  -v "${{ inputs.path }}:/repo" \
  merlyai/mentor@sha256:52381fd64b58afb7698cd191af3061a3dcb8dbb2e5701cac216fdec93c2ddfb5 \
  -D /repo --github-actions check [--debug --stdout]
```

---

## 📥 Download Free Trial

**[Download Free Trial](https://www.merly.ai/early-access)**

---

## 📄 License

[Apache License 2.0](LICENSE) © Merly.ai
