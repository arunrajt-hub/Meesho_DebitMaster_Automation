# OAuth Setup for GitHub Actions

Use OAuth when the **source sheet** is not shared with the service account. The script will use your Google account to copy the source, then the service account to push to the destination.

## One-time setup (do this once)

### 1. Create OAuth credentials (if you don't have them)

1. Go to [Google Cloud Console → Credentials](https://console.cloud.google.com/apis/credentials)
2. **Create credentials** → **OAuth client ID**
3. If prompted, configure OAuth consent screen (External, add your email as test user)
4. Application type: **Desktop app**
5. Download the JSON and save as `gspread_credentials.json`

### 2. Generate OAuth tokens (run locally)

Run the script locally once – it will open a browser for you to sign in:

```bash
cd Meesho_DebitMaster_Automation
python meesho_debit_master_sync.py
```

- Sign in with the Google account that has **view access** to the source sheet
- After success, `gspread_authorized_user.json` is created (tokens for reuse)

### 3. Add GitHub secrets

Go to: **Settings** → **Secrets and variables** → **Actions** → **New repository secret**

| Secret | Value |
|--------|-------|
| `GSPREAD_CREDENTIALS_JSON` | Full contents of `gspread_credentials.json` |
| `GSPREAD_AUTHORIZED_USER_JSON` | Full contents of `gspread_authorized_user.json` |

**Tip:** Copy the entire JSON (including `{` and `}`) – no extra spaces or newlines at start/end.

## Required in all cases

- `SERVICE_ACCOUNT_JSON` – for pushing to destination (dest sheet must be shared with SA)
- `GMAIL_APP_PASSWORD`, `WHAPI_TOKEN`, `WHATSAPP_PHONE` – for email & WhatsApp

## Token expiry

OAuth refresh tokens are long-lived. If you see auth errors later, run locally with `--reauth`, sign in again, then update the `GSPREAD_AUTHORIZED_USER_JSON` secret with the new file contents.
