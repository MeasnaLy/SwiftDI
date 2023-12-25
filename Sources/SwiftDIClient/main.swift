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

@Component
class Sample {
    private var age: Int = 0
    let id: Int
    private var name: String
    var gender: String = "male"
    var node: String?
}

@Component
class User {
    private var id: Int
}

class Main {
    @InjectClass
    var sample: Sample?
    
    @InjectClass
    var sample2: Sample?
    
    @InjectClass
    var user: User?
}

let classes:[InitializerDI.Type] = [Sample.self, User.self]
let context = Application.shared.startNewContext(classes: classes)

let main = Main()

if let user = main.user {
    let userRefId = Unmanaged.passUnretained(user).toOpaque()
    print("user refId: \(userRefId)")
}

if let userFromContext:User = context.getInstance(key: "User") {
    let userRefIdFromContextId = Unmanaged.passUnretained(userFromContext).toOpaque()
    print("user from context refId: \(userRefIdFromContextId)")
}

if let sample = main.sample, let sample2 = main.sample2 {
    let sampleRefId = Unmanaged.passUnretained(sample).toOpaque()
    print("sample refId: \(sampleRefId)")
    
    let sample2RefId = Unmanaged.passUnretained(sample2).toOpaque()
    print("sample2 refId: \(sample2RefId)")
}

if let sampleFromContext:Sample = context.getInstance(key: "Sample") {
    let sampleFromContextId = Unmanaged.passUnretained(sampleFromContext).toOpaque()
    print("sample from context refId: \(sampleFromContextId)")
}

print("finished")




