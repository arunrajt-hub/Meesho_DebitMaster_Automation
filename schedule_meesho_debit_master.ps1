# Schedule Meesho Debit Master to run daily at 8 PM IST
# Uses PC's local time - set Windows timezone to (UTC+05:30) India for IST
# Run as Administrator: Right-click -> Run as Administrator

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$taskName = "MeeshoDebitMasterSync"
$scriptPath = Join-Path $scriptDir "run_meesho_debit_master.bat"
$workingDir = $scriptDir

Unregister-ScheduledTask -TaskName $taskName -Confirm:$false -ErrorAction SilentlyContinue

$action = New-ScheduledTaskAction -Execute $scriptPath -WorkingDirectory $workingDir
$trigger = New-ScheduledTaskTrigger -Daily -At "8:00PM"
$principal = New-ScheduledTaskPrincipal -UserId "$env:USERDOMAIN\$env:USERNAME" -LogonType Interactive -RunLevel Highest
$settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -StartWhenAvailable -RunOnlyIfNetworkAvailable -WakeToRun -ExecutionTimeLimit (New-TimeSpan -Hours 2)

Register-ScheduledTask -TaskName $taskName -Action $action -Trigger $trigger -Principal $principal -Settings $settings -Description "Meesho Debit Master Sync - runs daily at 8 PM"

Write-Host "Task '$taskName' created. Schedule: Daily at 8:00 PM" -ForegroundColor Green
Write-Host "Test now: Start-ScheduledTask -TaskName '$taskName'" -ForegroundColor Cyan
