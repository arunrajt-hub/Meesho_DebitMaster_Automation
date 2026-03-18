# Meesho Debit Master Automation

Automates sync of Meesho Debit Master data: copy source sheet → analyze → push summary to destination → send to WhatsApp & email.

## Features

- **Copy & analyze**: Creates a fresh copy of the source sheet each run for up-to-date data
- **Summary tables**: Total Debit, Recovery Pending, Recovered (hub-wise, month-wise)
- **WhatsApp**: Sends Total Debit and Recovery Pending tables as images
- **Email**: Sends Recovery Pending report with hub-wise month-wise summary attachment
- **Optional**: Use OAuth when source isn't shared with service account

## Quick Start

```bash
# Install dependencies
pip install -r requirements.txt

# Configure (copy .env.example to .env and fill values)
# - service_account_key.json (from Google Cloud)
# - GMAIL_APP_PASSWORD (for Recovery Pending email)
# - WHAPI_TOKEN, WHATSAPP_PHONE (for WhatsApp)

# Run
python meesho_debit_master_sync.py
```

## Usage

```bash
# Default: Copy → Analyze → Push → Email → WhatsApp
python meesho_debit_master_sync.py

# From local file (skip Google copy)
python meesho_debit_master_sync.py --input downloaded.xlsx

# Skip WhatsApp or email
python meesho_debit_master_sync.py --no-whatsapp --no-email

# Push raw data instead of summary
python meesho_debit_master_sync.py --raw

# OAuth: use your Google account for copy (when source not shared with SA)
python meesho_debit_master_sync.py --reauth  # First time: opens browser to sign in
```

## Configuration

| Env / File | Purpose |
|------------|---------|
| `service_account_key.json` | Google Sheets/Drive access (required) |
| `GMAIL_APP_PASSWORD` | Recovery Pending email (16-char app password) |
| `GMAIL_SENDER_EMAIL` | Email sender (default: arunraj@loadshare.net) |
| `WHAPI_TOKEN` | WhatsApp API token |
| `WHATSAPP_PHONE` | WhatsApp recipient(s), comma-separated |
| `MEESHO_SPREADSHEET_ID` | Destination spreadsheet ID |

## Source / Destination

- **Source**: [Meesho Debit Master](https://docs.google.com/spreadsheets/d/1ZGJevEXRdBEy4HOUdfxi5X_F3gOU4FpdM0eOZH7Tf6E/edit) (shared with service account or your OAuth account)
- **Destination**: Meesho_Automated_Reports → Debit Master worksheet

## Schedule (Daily at 8 PM IST)

**Option 1: GitHub Actions** (cloud – no PC needed)
1. Add repository secrets: `Settings` → `Secrets and variables` → `Actions`
2. Required: `SERVICE_ACCOUNT_JSON`, `GMAIL_APP_PASSWORD`, `WHAPI_TOKEN`, `WHATSAPP_PHONE`
3. Optional: `GMAIL_SENDER_EMAIL`, `MEESHO_SPREADSHEET_ID`
4. Workflow runs automatically or manually via `Actions` → `Meesho Debit Master - Daily Sync` → `Run workflow`

**Option 2: Windows Task Scheduler** (local PC)
Run as Administrator. Uses your PC's local time—set Windows timezone to **(UTC+05:30) India** for 8 PM IST.

```powershell
cd "C:\path\to\Meesho_DebitMaster_Automation"
.\schedule_meesho_debit_master.ps1
```

The task `MeeshoDebitMasterSync` runs daily at 8:00 PM. Test manually: `Start-ScheduledTask -TaskName 'MeeshoDebitMasterSync'`

## OAuth Setup (Optional)

When the source sheet isn't shared with the service account, use OAuth so the script runs the copy with your Google account. See [MEESHO_DEBIT_MASTER_OAUTH_SETUP.md](MEESHO_DEBIT_MASTER_OAUTH_SETUP.md).
