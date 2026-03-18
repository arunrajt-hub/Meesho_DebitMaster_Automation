# Meesho Debit Master - OAuth Setup (Automate Copy)

When you can manually copy the source sheet (File → Make a copy) but the owner hasn't shared it with the service account, use **OAuth** so the script runs the copy with your own Google account.

## One-time setup

### 1. Google Cloud Console

1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Select your project (or create one)
3. Enable APIs: **APIs & Services** → **Library** → enable **Google Sheets API** and **Google Drive API**
4. **APIs & Services** → **Credentials**
4. **+ Create credentials** → **OAuth client ID**
5. If prompted, configure **OAuth consent screen**:
   - User type: External (or Internal for workspace)
   - App name: "Meesho Debit Sync"
   - Add your email as test user
6. Back to Credentials → **OAuth client ID**:
   - Application type: **Desktop app**
   - Name: "Meesho Debit Sync"
   - Create

### 2. Download credentials

1. Click the download icon for your OAuth client
2. Save the JSON file
3. Rename it to `gspread_credentials.json`
4. Place it in the same folder as `meesho_debit_master_sync.py`

### 3. First run

```powershell
python meesho_debit_master_sync.py
```

- A browser opens for Google sign-in
- Log in with the account that has **copy access** to the source sheet
- Approve the requested permissions
- Tokens are saved to `gspread_authorized_user.json` for future runs

### 4. Subsequent runs

No browser needed. The script runs the copy automatically.

## Usage

```powershell
# Default: OAuth (your account) - copies source every run
python meesho_debit_master_sync.py

# Use service account instead (owner must share source)
python meesho_debit_master_sync.py --service-account

# From file
python meesho_debit_master_sync.py --input downloaded.xlsx
```
