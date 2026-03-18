@echo off
REM Meesho Debit Master Sync - Daily automation
REM Schedule with: .\schedule_meesho_debit_master.ps1 (Run as Administrator)

cd /d "%~dp0"

python meesho_debit_master_sync.py

echo Meesho Debit Master ran at %date% %time% >> meesho_debit_master_log.txt
