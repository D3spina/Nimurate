import argparse
import strutils
import header
import links
import conn
import email
import certificate 
import comments
import javascript
import whois
import asyncdispatch

const
  reset = "\x1b[0m"
  red = "\x1b[31m"
  green = "\x1b[32m"
  yellow = "\x1b[33m"
  blue = "\x1b[34m"
  magenta = "\x1b[35m"
  cyan = "\x1b[36m"
  white = "\x1b[37m"

proc main() =
    var p = newParser:
        help("A description of this program {prog}")
        option("-t", "--target", help="url of the target with http:// or https://", required=true)
        flag("-f", "--full", help="fully discovering")
        flag("-he", "--header", help="check header") 
        flag("-l", "--links", help="search for all links")
        flag("-e", "--emails", help="search for emails")
        flag("-c", "--certificate", help="return certificates")
        flag("-co", "--comments", help="search for comments")
        flag("-j", "--javascript", help="search for javascript script")
        flag("-w", "--whois", help="request for whois")
        #hflag("-r", "--recursive", help="recursive search for all links found")
    
    try:
        let optionsParsed = p.parse(commandLineParams())
        var target = optionsParsed.target
        if not target.startsWith("http://") and not target.startsWith("https://"):
            raise newException(ValueError, "L'URL doit commencer par http:// ou https://")
        if target.endsWith("/"): 
            target = target[0 ..< target.len-1]
        
        echo blue & """.-----------------. .----------------.  .----------------.  .----------------.  .----------------.  .----------------.  .----------------.  .----------------. 
| .--------------. || .--------------. || .--------------. || .--------------. || .--------------. || .--------------. || .--------------. || .--------------. |
| | ____  _____  | || |     _____    | || | ____    ____ | || | _____  _____ | || |  _______     | || |      __      | || |  _________   | || |  _________   | |
| ||_   \|_   _| | || |    |_   _|   | || ||_   \  /   _|| || ||_   _||_   _|| || | |_   __ \    | || |     /  \     | || | |  _   _  |  | || | |_   ___  |  | |
| |  |   \ | |   | || |      | |     | || |  |   \/   |  | || |  | |    | |  | || |   | |__) |   | || |    / /\ \    | || | |_/ | | \_|  | || |   | |_  \_|  | |
| |  | |\ \| |   | || |      | |     | || |  | |\  /| |  | || |  | '    ' |  | || |   |  __ /    | || |   / ____ \   | || |     | |      | || |   |  _|  _   | |
| | _| |_\   |_  | || |     _| |_    | || | _| |_\/_| |_ | || |   \ `--' /   | || |  _| |  \ \_  | || | _/ /    \ \_ | || |    _| |_     | || |  _| |___/ |  | |
| ||_____|\____| | || |    |_____|   | || ||_____||_____|| || |    `.__.'    | || | |____| |___| | || ||____|  |____|| || |   |_____|    | || | |_________|  | |
| |              | || |              | || |              | || |              | || |              | || |              | || |              | || |              | |
| '--------------' || '--------------' || '--------------' || '--------------' || '--------------' || '--------------' || '--------------' || '--------------' |
 '----------------'  '----------------'  '----------------'  '----------------'  '----------------'  '----------------'  '----------------'  '----------------' """

        echo "Version : 1.0.0"
        echo "Created by D3spina"
        echo ""
        echo """This script is provided for educational purposes only. Use of this script for testing, either on your own systems or on systems for which you have legal authorization to perform such tests, is highly encouraged. However, executing this script on systems without such authorization is illegal and strictly forbidden. The creator of this script assumes no liability for misuse of this tool or any damage that might be caused by its appropriate or inappropriate use. It is the end user's responsibility to comply with all applicable local, state, and federal laws. Users must consider the impact of any actions they perform and be mindful of the applicable laws and rights of others.

By running this script, you agree to the terms of use and acknowledge that you have the necessary authorizations to perform such assessments.""" & reset
        echo ""
        
        if checkConn(target):
            if optionsParsed.full or optionsParsed.certificate:
                echo yellow & "----------------------------------------------------------------"
                echo "CERTIFICATES FOR ", target
                echo "----------------------------------------------------------------" & reset
                echo getCertificate(target)
            if optionsParsed.full or optionsParsed.whois:
                echo yellow & "----------------------------------------------------------------"
                echo "WHOIS FOR ", target
                echo "----------------------------------------------------------------" & reset
                echo waitFor getWhois(target) # Best way to do it. I plan to change the others
            if optionsParsed.full or optionsParsed.header:
                echo yellow & "----------------------------------------------------------------"
                echo "HEADER FOR ", target
                echo "----------------------------------------------------------------" & reset
                waitFor getHeader(target)
            if optionsParsed.full or optionsParsed.links:
                echo yellow & "----------------------------------------------------------------"
                echo "LINKS FOR ", target
                echo "----------------------------------------------------------------" & reset
                waitFor getLinks(target)
            if optionsParsed.full or optionsParsed.emails:
                echo yellow & "----------------------------------------------------------------"
                echo "EMAILS FOR ", target
                echo "----------------------------------------------------------------" & reset
                waitFor getEmails(target)
            if optionsParsed.full or optionsParsed.comments:
                echo yellow & "----------------------------------------------------------------"
                echo "COMMENTS FOR ", target
                echo "----------------------------------------------------------------" & reset
                waitFor getComments(target)
            if optionsParsed.full or optionsParsed.javascript:
                echo yellow & "----------------------------------------------------------------"
                echo "JAVASCRIPT FOR ", target
                echo "----------------------------------------------------------------" & reset
                waitFor getJavascript(target)
        else:
            echo red & "Unable to connect to the target." & reset

    except ShortCircuit:
        echo p.help
        quit(1)
    except UsageError:
        stderr.writeLine getCurrentExceptionMsg()
        echo p.help
        quit(1)
    

when isMainModule:
    main()
