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
name: mentor
uses: merly-ai/mentor-action@v1
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
3. Runs the MerlyMentor Docker image (pinned by version) as your runner user to avoid permission issues  
4. Streams analysis results back into your workflow logs  

## Example command for the action:

### You just want to try it out
```yaml

name: mentor
uses: merly-ai/mentor-action@v1
```

### You have a license key
```yaml

name: mentor
uses: merly-ai/mentor-action@v1
with:
  mm-key: {{ secret.mentor_key }}
```

### Something not right and you want to enable debug mode 
```yaml

name: mentor
uses: merly-ai/mentor-action@v1
with:
  mm-key: {{ secret.mentor_key }}
  debug: true
```

---

## 📥 Download Free Trial

**[Download Free Trial](https://www.merly.ai/early-access)**

#### Latest Release is 
v0.8.4
---

## 📄 License

[Apache License 2.0](LICENSE) © Merly.ai
