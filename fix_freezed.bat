@echo off
echo ==============================================
echo  AutoBID - Freezed Regeneration Script
echo ==============================================
echo.

cd /d "%~dp0"

echo Searching for Flutter SDK...
echo.

REM Check common Flutter locations
set FLUTTER_CMD=

if exist "C:\flutter\bin\flutter.bat" (
    set FLUTTER_CMD=C:\flutter\bin\flutter.bat
    goto :found
)

if exist "C:\src\flutter\bin\flutter.bat" (
    set FLUTTER_CMD=C:\src\flutter\bin\flutter.bat
    goto :found
)

if exist "%USERPROFILE%\flutter\bin\flutter.bat" (
    set FLUTTER_CMD=%USERPROFILE%\flutter\bin\flutter.bat
    goto :found
)

if exist "D:\flutter\bin\flutter.bat" (
    set FLUTTER_CMD=D:\flutter\bin\flutter.bat
    goto :found
)

REM Try using flutter from PATH
where flutter >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    set FLUTTER_CMD=flutter
    goto :found
)

REM Search in Program Files
for /f "delims=" %%i in ('dir /s /b "C:\Program Files\flutter.bat" 2^>nul') do (
    set FLUTTER_CMD=%%i
    goto :found
)

REM Search in user directory (limited depth)
for /f "delims=" %%i in ('dir /s /b "%USERPROFILE%\flutter.bat" 2^>nul ^| findstr /v "Recycle" ^| findstr /i "bin\\flutter.bat"') do (
    set FLUTTER_CMD=%%i
    goto :found
)

echo [ERROR] Flutter SDK not found!
echo.
echo Please install Flutter or add it to your PATH.
echo Visit: https://docs.flutter.dev/get-started/install/windows
echo.
echo Or run this from VS Code/Android Studio terminal where Flutter is configured.
echo.
pause
exit /b 1

:found
echo [OK] Found Flutter: %FLUTTER_CMD%
echo.

echo Step 1: Running flutter pub get...
echo.
call "%FLUTTER_CMD%" pub get
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] flutter pub get failed!
    pause
    exit /b 1
)

echo.
echo Step 2: Running build_runner...
echo.
call "%FLUTTER_CMD%" pub run build_runner build --delete-conflicting-outputs
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] build_runner failed!
    pause
    exit /b 1
)

echo.
echo Step 3: Running flutter analyze...
echo.
call "%FLUTTER_CMD%" analyze
if %ERRORLEVEL% NEQ 0 (
    echo [WARNING] Flutter analyze found issues. Check output above.
    echo.
    pause
    exit /b 0
)

echo.
echo ==============================================
echo [SUCCESS] All steps completed successfully!
echo ==============================================
echo.
pause
