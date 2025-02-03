import std/httpclient

proc checkConn*(target:string): bool = 
    var client = newHttpClient()
    try:
        let response = client.request(target, HttpHead)
        if response.status == "200 OK":
            return true
        else:
            return false
    finally:
        client.close()
