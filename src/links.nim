import std/httpclient
import pkg/htmlparser
import std/xmltree  # To use '$' for XmlNode
import std/strtabs  # To access XmlAttributes
import std/strutils

proc getLinks*(target: string) =
  var client = newHttpClient()
  try:
    let response = client.get(target)
    let html = response.body

    echo "----------------------------------------------------------------"
    echo "LINKS FOR ", target
    echo "----------------------------------------------------------------"

    let document = parseHtml(html)
    for a in document.findAll("a"):
        if a.attrs.hasKey "href":
            if not a.attrs["href"].startsWith("#") and not a.attrs["href"].startsWith("\\"):
                echo a.attrs["href"]
    
    echo "----------------------------------------------------------------"

  finally:
    client.close()