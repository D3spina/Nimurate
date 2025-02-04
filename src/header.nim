import std/[asyncdispatch, httpclient]

proc getHeader*(target: string) {.async.} =
  var client = newAsyncHttpClient()
  try:
    let response = await client.head(target)
    echo response.headers

  finally:
    client.close()