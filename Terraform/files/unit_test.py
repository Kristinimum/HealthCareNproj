#This if statement will allow us to check if our website name matches in our index.html file.
#Conditional statements are case sensitive.

file_path = "index.html"
expected_title = "HealthCare Hospital"
error_message = "Website title did not match expected value"

try:
    with open(file_path, 'r') as file:
        html_content = file.read()
       
        if expected_title in html_content:
            print("Website title matches expected value:", expected_title)
        else:
            print(error_message)
except FileNotFoundError:
    print("File not found:", file_path)
except Exception as e:
    print("An error occurred:", str(e))
