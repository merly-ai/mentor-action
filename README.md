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

| Input                 | Description                                                                                                              | Default                     |
| --------------------- | ------------------------------------------------------------------------------------------------------------------------ | --------------------------- |
| `mm-key`              | Merly API key (store as repo secret `MM_KEY`).                                                                           | _none_                      |
| `checkout-code`       | Perform `actions/checkout` internally? (`true` or `false`)                                                               | `true`                      |
| `path`                | Path to your repo on disk (for custom checkouts)                                                                         | `${{ github.workspace }}`   |
| `debug`               | Enable Mentor’s debug & stdout output (`true` or `false`)                                                                | `false`                     |
| `max-issue-count`     | **Total** number of new issues (of any priority) allowed before failing the pipeline.                                     | `0`                         |
| `max-issue-priority`  | Fail immediately if **any** issue meets or exceeds this priority level (`0–4` or `Low`/`Medium`/`High`/`Critical`).       | `0`                         |

---

## 🛠️ How It Works

1. **(Optional)** Checks out your repository  
2. Binds your code into the container at `/repo`  
3. Runs the MerlyMentor Docker image (pinned by version) as your runner user to avoid permission issues  
4. Streams analysis results back into your workflow logs  

---

## 📋 Examples

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
  mm-key: ${{ secrets.mentor_key }}
```

### Something not right and you want to enable debug mode 
```yaml
name: mentor
uses: merly-ai/mentor-action@v1
with:
  mm-key: ${{ secrets.mentor_key }}
  debug: true
```

### Fail on too many issues (any priority)
```yaml
name: mentor
uses: merly-ai/mentor-action@v1
with:
  max-issue-count: 5
```
> This will fail if there are **5 or more** issues of _any_ priority.

### Fail on high‑priority issues (regardless of count)
```yaml
name: mentor
uses: merly-ai/mentor-action@v1
with:
  max-issue-priority: High
```
> This will fail as soon as **any** issue is High or Critical, even if there are fewer than 5 issues overall.

### Combine both checks
```yaml
name: mentor
uses: merly-ai/mentor-action@v1
with:
  max-issue-count:     5
  max-issue-priority:  High
```
> This will fail if **either**:
> - You have **5 or more** issues of any priority, **or**
> - You have **any** issue at High or above (e.g. 3 Low + 1 High will fail immediately).

---

## 📥 Download Free Trial

**[Download Free Trial](https://www.merly.ai/early-access)**

#### Latest Release is 
v0.9.0
---

## 📄 License

[Apache License 2.0](LICENSE) © Merly.ai
