import std/httpclient

proc getHeader*(target: string) =
  var client = newHttpClient()
  try:
    let response = client.head(target)
    echo "----------------------------------------------------------------"
    echo "HEADERS FOR ", target
    echo "----------------------------------------------------------------"
    echo response.headers
    echo "----------------------------------------------------------------"

  finally:
    client.close()