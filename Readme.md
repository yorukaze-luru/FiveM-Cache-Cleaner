---

# 🧹 FiveM Cache Cleaner — ReadMe

FiveM のキャッシュフォルダを安全に削除し、  
必要に応じて FiveM を自動起動するためのバッチツールです。

---

## 📁 ファイル構成

| ファイル名 | 説明 |
|-----------|------|
| **run.bat** | キャッシュ削除と自動起動を行うメインスクリプト |
| **setting.txt** | ユーザー設定（path / autoStart）を記述するファイル |

---

## ⚙️ setting.txt の設定方法

### 1. **cache フォルダまでのパスを指定する**

例：

```txt
path="C:\Users\あなた\AppData\Local\FiveM\FiveM.app\data"
```

#### ⚠️ 注意  
以下の場合は警告メッセージが表示され、  
**OK を押すと setting.txt が自動で開きます。**

- `path=""`（空欄）
- 指定されたフォルダが存在しない（間違ったパス）

---

### 2. **FiveM を自動起動するかどうか**

自動起動したい場合は次の行のコメントを外し、`true` を指定します。

```txt
autoStart=true
```

#### ⚠️ 自動起動しない条件  
以下の場合は **自動起動しません**：

- コメントアウトされている  
- 記述されていない  
- 空欄  
- `false`  
- `true` 以外の値（例：`1`, `on`, `yes` など）

---

## 🚀 run.bat の動作

1. **setting.txt を読み取る**
2. **path が正しいかチェック**
   - 未指定または間違い → 警告 → setting.txt を開いて終了
3. **cache / server-cache / server-cache-priv を削除**
4. **削除したフォルダ数をカウント**
5. **autoStart=true の場合**
   - FiveM を起動してバッチ終了
6. **autoStart が true 以外の場合**
   - 削除数を表示するメッセージボックスを出して終了

---

## 📌 注意事項

- `path` は必ず **cache フォルダの一つ上の階層**を指定してください  
  例：  
  ```
  C:\Users\あなた\AppData\Local\FiveM\FiveM.app\data
  ```

- 削除されるフォルダは以下の3つです：
  - `cache`
  - `server-cache`
  - `server-cache-priv`

- このツールは FiveM の動作には影響しません。

---

## 💻 推奨環境

- Windows 10 / 11  
- FiveM 最新版  
- PowerShell が利用可能な環境  

---

## 👤 作成者

**夜風るる**  
X: [https://x.com/Yorukaze_LURU](https://x.com/Yorukaze_LURU)

---
