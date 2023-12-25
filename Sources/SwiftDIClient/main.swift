import SwiftDI
import Foundation

//@ApplicationDI("SwiftDIClient")
//class AppDelegate  {
// 
//}
//
//@ComponentDI()
//class UserService {
//}
//
//@ComponentDI()
//class CardService {
//}
//
//@ComponentDI()
//class TestService  {
//    
////    @InjectClass
//    var userService: UserService?
//    
////    @InjectClass
//    var cardService: CardService?
//}
//
//
//let app = CardService()
//
//

@ComponentDI()
class Sample {
    private var age: Int = 0
    let id: Int
    private var name: String
    var gender: String = "male"
    var node: String?
}

@ComponentDI()
class User {
    private var id: Int
    
    @InjectClass
    var sample: Sample?
    
}



let classes:[InitializerDI.Type] = [Sample.self, User.self]
let context = Application.shared.startNewContext(classes: classes)

let user = User(id: 1)
print("user: \(String(describing: user.sample))")

if let user1:User = context.getInstance(key: "User") {
    print("user1: \(user.sample)")
}




print("finished")
print("finished12")




