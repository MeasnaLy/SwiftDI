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
    
    func application(_ application: String, didFinishLaunchingWithOptions launchOptions: [String : Any]? = nil) -> Bool {
        let context = #ConfigContext
        
        if let userViewModel:UserViewModel = context.getInstance(key: "UserViewModel") {
            let id = Unmanaged.passUnretained(userViewModel).toOpaque()
            print("id from context: \(id)")
        }

        
        return true
    }
}

let classes:[InitializerDI.Type] = [UserRepository.self, UserViewModel.self]
let context = ApplicationContext.shared.startContext(classes: classes)

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

let _ = main.application("Test")

print("finished")





