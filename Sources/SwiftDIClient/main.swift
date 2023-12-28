import SwiftDI
import Foundation

@Component
class UserRepository {
    private var age: Int = 0
    let id: Int
    private var name: String
    var gender: String = "male"
    var node: String?
}

@Component
class UserViewModel {
    @Inject(.context)
    var userRepository: UserRepository?
}

class Main {
    @Inject(.context)
    var userViewModel: UserViewModel?
    
    @Inject(.context)
    var userViewModel1: UserViewModel?
    
    @Inject(.new)
    var userViewModelNew: UserViewModel?
}

let classes:[InitializerDI.Type] = [UserRepository.self, UserViewModel.self]
let context = Application.shared.startNewContext(classes: classes)

let main = Main()

if let userViewModel = main.userViewModel {
    let id = Unmanaged.passUnretained(userViewModel).toOpaque()
    print("user refId: \(id)")
}

if let userViewModel:UserViewModel = context.getInstance(key: "UserViewModel") {
    let id = Unmanaged.passUnretained(userViewModel).toOpaque()
    print("id from context: \(id)")
}

if let userViewModel1 = main.userViewModel1 {
    let id1 = Unmanaged.passUnretained(userViewModel1).toOpaque()
    print("user refId: \(id1)")
}

if let userViewModelNew = main.userViewModelNew {
    let newId = Unmanaged.passUnretained(userViewModelNew).toOpaque()
    print("new user refId: \(newId)")
}

print("finished")



