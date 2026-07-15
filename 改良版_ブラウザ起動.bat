@echo off
chcp 65001 >nul
setlocal
title 勉強記録アプリ 改良版
cd /d "%~dp0"

if not exist "pubspec.yaml" (
  echo pubspec.yaml が見つかりません。
  pause
  exit /b 1
)

where flutter >nul 2>&1
if errorlevel 1 (
  echo Flutter が見つかりません。
  pause
  exit /b 1
)

echo 改良版を起動します。
echo URL: http://localhost:8081
echo 終了するときは Ctrl+C を押してください。
call flutter run -d chrome --web-hostname=localhost --web-port=8081

if errorlevel 1 (
  echo 起動に失敗しました。
  pause
  exit /b 1
)

endlocal
