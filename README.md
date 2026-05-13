# trae_config

个人 TRAE IDE 配置文件，通过 Git 管理，支持 macOS / Windows / Linux 跨设备同步。

## 仓库结构

```
trae_config/
├── trae/
│   ├── keybindings.json   # 快捷键配置
│   └── settings.json      # 全局设置
├── install.sh             # macOS / Linux 安装脚本
├── install.ps1            # Windows 安装脚本
├── install.bat            # Windows 安装脚本入口
└── README.md
```

安装脚本会在 TRAE 配置目录中创建**符号链接**指向本仓库中的文件。之后每次 `git pull` 拉取最新配置，TRAE 会立即生效，无需手动复制。

---

## 新电脑首次安装

### macOS / Linux

```bash
git clone git@github.com:YOUR_USERNAME/trae_config.git ~/trae_config
cd ~/trae_config
chmod +x install.sh
./install.sh
```

### Windows（以管理员身份运行）

```powershell
git clone git@github.com:YOUR_USERNAME/trae_config.git $HOME\trae_config
cd $HOME\trae_config
install.bat
```

> **Windows 提示：** 如果不想每次用管理员权限，可在  
> **设置 → 隐私和安全性 → 开发者选项** 中开启**开发人员模式**，  
> 开启后普通用户也可以创建符号链接。

安装完成后，如果 TRAE 已经打开，重启一次即可生效。

---

## 日常使用

### 修改配置

直接在 TRAE 中通过设置界面打开并编辑，或者直接编辑 `trae/` 目录下的文件。由于配置文件是符号链接，修改会直接写回仓库。

### 推送到 GitHub

```bash
cd ~/trae_config
git add trae/
git commit -m "config: update keybindings"
git push
```

### 在另一台电脑同步

```bash
cd ~/trae_config
git pull
# TRAE 立即读取新配置，无需重启
```

---

## 各平台配置路径参考

| 平台    | TRAE 配置目录                                          |
|---------|--------------------------------------------------------|
| macOS   | `~/Library/Application Support/Trae CN/User/`          |
| Windows | `%APPDATA%\Trae CN\User\`                              |
| Linux   | `~/.config/Trae CN/User/`                              |

安装脚本会自动检测操作系统并链接到对应路径。

---

## 跨平台快捷键写法

一份 `keybindings.json` 可以同时兼容 macOS 和 Windows，使用 `when` 条件区分平台：

```jsonc
[
  // macOS
  { "key": "cmd+k", "command": "some.command", "when": "isMac" },
  
  // Windows / Linux
  { "key": "ctrl+k", "command": "some.command", "when": "isWindows || isLinux" }
]
```