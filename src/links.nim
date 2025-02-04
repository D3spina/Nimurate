import std/[asyncdispatch, httpclient]
import pkg/htmlparser
import std/xmltree  # To use '$' for XmlNode
import std/strtabs  # To access XmlAttributes
import std/strutils

proc getLinks*(target: string) {.async.} =
  var client = newAsyncHttpClient()
  try:
    let response = await client.get(target)
    let html = await response.body
    let document = parseHtml(html)
    for a in document.findAll("a"):
        if a.attrs.hasKey "href":
            if not a.attrs["href"].startsWith("#") and not a.attrs["href"].startsWith("\\"):
                echo a.attrs["href"]
  finally:
    client.close()