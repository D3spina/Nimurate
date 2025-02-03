import std/httpclient
import re

proc getEmails*(target: string) =
  var client = newHttpClient()
  try:
    let response = client.get(target)
    let html = response.body

    echo "----------------------------------------------------------------"
    echo "EMAILS FOR ", target
    echo "----------------------------------------------------------------"

    let emailRegex = re(r"\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,7}\b")
    for email in findAll(html, emailRegex):
        echo email
    
    echo "----------------------------------------------------------------"

  finally:
    client.close()