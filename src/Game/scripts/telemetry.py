import gspread
from oauth2client.service_account import ServiceAccountCredentials

# Authenticate with Google Sheets API
scope = ['https://www.googleapis.com/auth/spreadsheets']
creds = ServiceAccountCredentials.from_json_keyfile_name('your_service_account.json', scope)
client = gspread.authorize(creds)

# Open Spreadsheet
sheet = client.open_by_key('YOUR_SPREADSHEET_ID')
worksheet = sheet.worksheet('YOUR_WORKSHEET_NAME')

#5. Prepare the data

#6. Append the data to the worksheet
worksheet.append_row(data)