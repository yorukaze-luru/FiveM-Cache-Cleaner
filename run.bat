@echo off
setlocal
chcp 65001 >nul
title FiveM Cache Cleaner

rem ============================================
rem setting.txt から path="..." と autoStart=true を抽出
rem ============================================

set "dataPath="
set "autoStart="

rem path= の行を取得（コメントアウト行は findstr に拾われない）
for /f "usebackq tokens=1,2 delims==" %%a in (`findstr /r /b /c:"path=" setting.txt`) do (
    set rawPath=%%b
)

rem autoStart= の行を取得
for /f "usebackq tokens=1,2 delims==" %%a in (`findstr /r /b /c:"autoStart=" setting.txt`) do (
    set rawAuto=%%b
)

rem 両端の " を除去
if defined rawPath set "dataPath=%rawPath:"=%"
if defined rawAuto set "autoStart=%rawAuto:"=%"

rem ============================================
rem path 未指定 or 間違い → 警告＋setting.txt を開いて終了
rem ============================================
if not defined dataPath (
    powershell -Command "Add-Type -AssemblyName PresentationFramework;[System.Windows.MessageBox]::Show('setting.txt に path が設定されていません。例: \"C:\Users\あなた\AppData\Local\FiveM\FiveM.app\data\"','FiveM Cache Cleaner - 警告',[System.Windows.MessageBoxButton]::OK,[System.Windows.MessageBoxImage]::Warning)"
    start "" setting.txt
    exit /b
)

if not exist "%dataPath%" (
    powershell -Command "Add-Type -AssemblyName PresentationFramework;[System.Windows.MessageBox]::Show('setting.txt の path が正しくありません。例: \"C:\Users\あなた\AppData\Local\FiveM\FiveM.app\data\"','FiveM Cache Cleaner - 警告',[System.Windows.MessageBoxButton]::OK,[System.Windows.MessageBoxImage]::Warning)"
    start "" setting.txt
    exit /b
)

echo ========================================
echo   FiveM Cache Cleaner
echo ========================================
echo(
echo Data Path: %dataPath%
echo AutoStart Raw Value: %autoStart%
echo(

rem ============================================
rem 削除対象フォルダを targets にまとめる
rem ============================================
set "targets="%dataPath%\cache" "%dataPath%\server-cache" "%dataPath%\server-cache-priv""
set "count=0"

echo 削除を開始します...
echo --------------------------------

rem ============================================
rem 削除処理
rem ============================================
for %%i in (%targets%) do (
    if exist "%%~i" (
        rmdir /s /q "%%~i"
        echo [削除成功] %%~i
        set /a count+=1
    ) else (
        echo [スキップ] %%~i は見つかりませんでした
    )
)

echo(
echo ========================================
echo   完了しました！
echo ========================================
echo(

rem ============================================
rem autoStart=true のときだけ自動起動
rem ============================================
if /i "%autoStart%"=="true" (
    echo FiveM を起動します…
    start "" "%localappdata%\FiveM\FiveM.exe"
    exit /b
)

rem ============================================
rem autoStart が true 以外 → メッセージボックスを表示して閉じる
rem ============================================
powershell -Command "Add-Type -AssemblyName PresentationFramework;[System.Windows.MessageBox]::Show('%count% 個のフォルダ削除が完了しました','FiveM Cache Cleaner',[System.Windows.MessageBoxButton]::OK,[System.Windows.MessageBoxImage]::Information)"

exit /b
