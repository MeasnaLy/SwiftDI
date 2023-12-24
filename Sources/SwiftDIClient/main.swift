import SwiftDI
import Foundation

Application.shared.startNewContext(package: "")

@ApplicationDI("SwiftDIClient")
class AppDelegate  {
 
}

@ComponentDI(name: "userService")
class UserService {
    required init(){}
}

@ComponentDI(name: "cardService")
class CardService {
    required init(){}
}

@ComponentDI(name: "testService")
class TestService  {
    
//    @InjectClass
    var userService: UserService?
    
//    @InjectClass
    var cardService: CardService?
    
    required init(){}
    
}

let app = CardService()


//Application.shared.addClass("SwiftDIClient.TestService")
//Application.shared.addClass("SwiftDIClient.UserService")
//Application.shared.addClass("SwiftDIClient.CardService")
//Application.shared.createClass()
//Application.shared.printTest()

print("finished")
print("finished12")




