import std/httpclient
import strutils

proc getCertificate*(target: string) =
  var client = newHttpClient()
  var filtered: string = ""
  try:
    if target.startsWith("http"):
      filtered = target.substr(7)
    if target.startsWith("https"):
      filtered = target.substr(8)
    if target.startsWith("https://www."):
      filtered = target.substr(12)

    #[ let url = if filtered.len > 0:
                "https://crt.sh/?q=" & filtered & "&output=json"
              else:
                "https://crt.sh/?q=" & target & "&output=json"

    let response = client.get(url) ]#
    echo "----------------------------------------------------------------"
    echo "CERTIFICATES FOR ", target
    echo "----------------------------------------------------------------"
    # echo response.body
    if filtered.len > 0:
      echo "https://crt.sh/?q=" & filtered
    else:
      echo "https://crt.sh/?q=" & target
    echo "----------------------------------------------------------------"

  finally:
    client.close()