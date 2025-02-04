import std/[asyncdispatch, httpclient]
import pkg/htmlparser
import std/xmltree
import std/strtabs
import std/strutils

proc getJavascript*(target: string): Future[seq[string]] {.async.} =
  var client = newAsyncHttpClient()
  var result: seq[string] = @[]
  
  try:
    let response = await client.get(target)
    let html = await response.body
    let document = parseHtml(html)
    
    for script in document.findAll("script"):
      if script.attrs.hasKey "src":
        result.add(script.attrs["src"])

  finally:
    client.close()

  return result