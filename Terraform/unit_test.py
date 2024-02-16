#This if statement will allow us to check if our website name matches in our index.html file.
#Conditional statements are case sensitive.

website_title = "HealthCare Hospital"
error_message = "Website title did not match expected value"

if website_title == "HealthCare Hospital":
    print(website_title)
else:
    print(error_message)
