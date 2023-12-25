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
    
    func descrip()-> String  {
        return "age: \(age), id: \(id), name: \(name), gender: \(gender), node: \(node ?? "nil")"
    }
}

let classes = [Sample.self]
let context = Application.shared.startNewContext(classes: classes)
//Application.shared.createClass()
Application.shared.printTest()

if let instance = context.getInstance(key: "Sample")  {
    let sample: Sample = instance as! Sample
    print("sample: \(sample.descrip())")
}

// TODO: ignore:
// let a = 0
// some variable condition



print("finished")
print("finished12")




