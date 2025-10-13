import UIKit

let sessionIDCommandString = "SessionID:"
let commandString = "SessionID:123"

let newSessionID = String(
    commandString[
        commandString.index(commandString.startIndex, offsetBy: sessionIDCommandString.count)...
    ]
)

//newSessionID结果为"123"
