import std/httpclient
import re

proc getComments*(target: string) =
  var client = newHttpClient()
  try:
    let response = client.get(target)
    let html = response.body

    echo "----------------------------------------------------------------"
    echo "COMMENTS FOR ", target
    echo "----------------------------------------------------------------"

    let commentRegex = re(r"<!--(.*?)-->")
    for comment in findAll(html, commentRegex):
        echo comment
    
    echo "----------------------------------------------------------------"

  finally:
    client.close()