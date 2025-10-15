@echo off
echo Regenerating Freezed files...
echo.
flutter pub get
echo.
echo Running build_runner...
flutter pub run build_runner build --delete-conflicting-outputs
echo.
echo Done! Press any key to exit.
pause
