@echo off
REM install.bat — Windows 安装脚本入口，调用 PowerShell 脚本
powershell -ExecutionPolicy Bypass -File "%~dp0install.ps1"
pause
