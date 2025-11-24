# PowerShell script to regenerate Freezed files
Write-Host "Regenerating Freezed files..." -ForegroundColor Green
Write-Host ""

Set-Location "C:\Users\nekol\Desktop\Flutter\AutoBID\autobid"

Write-Host "Running flutter pub get..." -ForegroundColor Yellow
flutter pub get

Write-Host ""
Write-Host "Running build_runner..." -ForegroundColor Yellow
flutter pub run build_runner build --delete-conflicting-outputs

Write-Host ""
Write-Host "Done!" -ForegroundColor Green
Write-Host "Press any key to exit..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
