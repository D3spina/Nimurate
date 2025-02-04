import std/[asyncdispatch, httpclient]
import pkg/htmlparser
import std/xmltree
import std/strtabs
import std/strutils

proc getLinks*(target: string): Future[seq[string]] {.async.} =
  var client = newAsyncHttpClient()
  var result: seq[string] = @[]
  try:
    let response = await client.get(target)
    let html = await response.body
    let document = parseHtml(html)
    
    for a in document.findAll("a"):
      if a.attrs.hasKey "href":
        if not a.attrs["href"].startsWith("#") and not a.attrs["href"].startsWith("\\"):
          result.add(a.attrs["href"])

  finally:
    client.close()
  
  return result