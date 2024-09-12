import gspread
from oauth2client.service_account import ServiceAccountCredentials

# Your service account credentials file location
credentials_file = 'your_service_account.json'

# Spreadsheet ID and worksheet name (replace with yours)
spreadsheet_id = 'YOUR_SPREADSHEET_ID'
worksheet_name = 'YOUR_WORKSHEET_NAME'

# Authenticate with Google Sheets API
scope = ['https://www.googleapis.com/auth/spreadsheets']
creds = ServiceAccountCredentials.from_json_keyfile_name(credentials_file, scope)
client = gspread.authorize(creds)

# Open Spreadsheet
sheet = client.open_by_key(spreadsheet_id)
worksheet = sheet.worksheet(worksheet_name)

# Prepare data (example)
data = [
    ["Column 1 Value 1", "Column 2 Value 1", "Column 3 Value 1"],
    ["Column 1 Value 2", "Column 2 Value 2", "Column 3 Value 2"]
]

# Append the data to the worksheet
worksheet.append_row(data)

print("Data appended successfully!")