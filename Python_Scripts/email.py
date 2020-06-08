
import win32com.client as win32
outlook = win32.Dispatch('outlook.application')
mail = outlook.CreateItem(0)
mail.To = 'chopson@primroseschools.com
mail.Subject = 'Email sent using Python'
#mail.Body = 'Brought to you by the galactic federation of scientologists.'

mail.HTMLBody = '<h2>got it working</h2>' #this field is optional

To attach a file to the email (optional):
attachment  = 'C:\\Users\\joshu\\Desktop\\Desktop\\test attachment.txt'
mail.Attachments.Add(attachment)

mail.Send()

import pandas as pd 
from google.cloud import bigquery
import google.auth
from email.mime.text import MIMEText
from email.mime.application import MIMEApplication
from email.mime.multipart import MIMEMultipart
from smtplib import SMTP
import smtplib
import sys
import ssl

project_id = "analytics-met-thd"

client = bigquery.Client(project=project_id)   

df = pd.DataFrame(     client.query("""SELECT * FROM `analytics-met-thd.MET_Reporting.MV_GS_RE` LIMIT 10""")     .result()     )

recipients = ['adam_barton@homedepot.com','josh_levy@homedepot.com'] 
emaillist = [elem.strip().split(',') for elem in recipients]
msg = MIMEMultipart()
msg['Subject'] = "I did this in Python!!!"
msg['From'] = 'thejoshlevy@gmail.com'


html = """\
<html>
  <head></head>
  <body>
    {0}
  </body>
</html>
""".format(df.to_html())

part1 = MIMEText(html, 'html')
msg.attach(part1)

server = smtplib.SMTP('smtp.gmail.com',587)
server.starttls()
server.login('thejoshlevy@gmail.com','MY GMAIL APPLICATION PASSWORD THAT I'M NOT GIVING OUT')

server.sendmail(msg['From'], emaillist , msg.as_string())
server.quit()
