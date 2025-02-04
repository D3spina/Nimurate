import std/[asyncdispatch, httpclient]
import re

proc getComments*(target: string) {.async.} =
  var client = newAsyncHttpClient()
  try:
    let response = await client.get(target)
    let html = await response.body
    let commentRegex = re(r"<!--(.*?)-->")
    for comment in findAll(html, commentRegex):
        echo comment
  finally:
    client.close()