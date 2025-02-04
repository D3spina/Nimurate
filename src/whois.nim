import json
import strutils
import asyncnet
import asyncdispatch

proc getWhois*(target: string): Future[string] {.async.} =  # Ajout explicite du Future[string]
    let suffix = target.split(".")[^1]
    var domain = ""
    if target.startsWith("https://www") or target.startsWith("www"):
        domain = target.split(".", 1)[1]
    else:
        domain = target.split("//")[1]
    try:
        echo domain
        let jsonString = readFile("src/Ressource/whois_servers.json")
        let jsonData = parseJson(jsonString)
        let whoisServer = jsonData[suffix].getStr()

        var socket = await asyncnet.dial(whoisServer, Port(43))  
        await socket.send(domain & "\r\n")
        
        var rawResp = ""
        while true:
            let chunk = await socket.recv(4096)
            if chunk.len == 0:
                break
            rawResp &= chunk
        
        socket.close()
        return rawResp
        
    except CatchableError:
        return "File whois_servers.json not found or other error occurred"