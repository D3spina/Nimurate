import std/[asyncdispatch, httpclient]
import re

proc getJavascript*(target: string) {.async.} =
  var client = newAsyncHttpClient()
  try:
    let response = await client.get(target)
    let html = await response.body
    let commentRegex = re(r"<script> (.*?) </script>")
    for script in findAll(html, commentRegex):
        echo html
  finally:
    client.close()