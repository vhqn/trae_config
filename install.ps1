# install.ps1 — 将 trae/ 配置文件链接到 Windows 上的 TRAE 配置目录
# 需要管理员权限运行，或者在 Windows 设置中开启开发者模式（允许创建符号链接）

param()

$ErrorActionPreference = "Stop"

$DotfilesDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$SrcKeybindings = Join-Path $DotfilesDir "trae\keybindings.json"
$SrcSettings = Join-Path $DotfilesDir "trae\settings.json"

$Targets = @{
    "Keybindings" = "$env:APPDATA\Trae CN\User\keybindings.json"
    "Settings" = "$env:APPDATA\Trae CN\User\settings.json"
}

$Sources = @{
    "Keybindings" = $SrcKeybindings
    "Settings" = $SrcSettings
}

function Link-File {
    param([string]$Name, [string]$Src, [string]$Dst)

    $Dir = Split-Path -Parent $Dst

    if (-not (Test-Path $Dir)) {
        Write-Host "  [skip] directory not found: $Dir"
        return
    }

    $item = Get-Item $Dst -ErrorAction SilentlyContinue
    if ($item -and $item.LinkType -ne "SymbolicLink") {
        Write-Host "  [backup] $Dst -> $Dst.bak"
        Move-Item $Dst "$Dst.bak" -Force
    }

    New-Item -ItemType SymbolicLink -Path $Dst -Target $Src -Force | Out-Null
    Write-Host "  [linked] $Dst"
}

Write-Host "==> Linking TRAE config files ..."
foreach ($name in $Targets.Keys) {
    Link-File -Name $name -Src $Sources[$name] -Dst $Targets[$name]
}

Write-Host ""
Write-Host "Done! Restart TRAE if it is already open."