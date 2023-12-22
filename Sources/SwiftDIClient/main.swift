import SwiftDI
import Foundation


@ApplicationDI("SwiftDIClient")
class AppDelegate  {
 
}

//@ComponentDI(name: "userService")
class UserService {
    var username: String
    
    init() {
        self.username = "lazi"
    }
    
    init(username: String) {
        self.username = username
    }
}

@ComponentDI(name: "cardService")
class CardService {
    var name: String
    
    init() {
        self.name = "7 Hero"
    }
    
    init(name: String) {
        self.name = name
    }
}

@ComponentDI(name: "testService")
class TestService  {
    
//    @InjectClass
    var userService: UserService?
    
//    @InjectClass
    var cardService: CardService?
    
    init() {
        
    }
}


let app = TestService()
print(app.userService ?? "nil")
print(app.cardService ?? "nil")

print("finished")
print("finished12")




