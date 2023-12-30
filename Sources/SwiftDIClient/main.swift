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

class UserViewModelNew {
}

@Contract
@objc protocol ApiClient {
    func fetchData()
}

@Component
class ApiClientImpl: ApiClient {
    func fetchData() {
        print("FetchData in ApiClientImpl")
    }
}

@Component
class ApiClientMock : ApiClient {
    func fetchData() {
        print("FetchData in ApiClientMock")
    }
}

class Main {
        
    @Inject
    var userViewModel: UserViewModel?
    
    @Inject(.context)
    var userViewModel1: UserViewModel?
    
    @Inject(.new)
    var userViewModelNew: UserViewModel?
    
    @Inject(.new, qualifier: ApiClientMock.self)
    var apiClient: ApiClient?
    
    func application(_ application: String, didFinishLaunchingWithOptions launchOptions: [String : Any]? = nil) -> Bool {
        let context = #ConfigContext
        
        if let userViewModel:UserViewModel = context.getInstance(className: "UserViewModel") {
            let id = Unmanaged.passUnretained(userViewModel).toOpaque()
            print("id from context: \(id)")
        }

        
        return true
    }
}

//let classes:[InitializerDI.Type] = [UserRepository.self, UserViewModel.self, ApiClientImpl.self, ApiClientMock.self]
//let context = ApplicationContext.shared.startContext(classes: classes)

let main = Main()
let _ = main.application("Test")

if let userViewModel = main.userViewModel {
    let id = Unmanaged.passUnretained(userViewModel).toOpaque()
    print("user refId: \(id)")
}

//if let userViewModel:UserViewModel = context.getInstance(className: "UserViewModel") {
//    let id = Unmanaged.passUnretained(userViewModel).toOpaque()
//    print("id from context: \(id)")
//}

if let userViewModel1 = main.userViewModel1 {
    let id1 = Unmanaged.passUnretained(userViewModel1).toOpaque()

    print("user refId: \(id1)")
}

if let userViewModelNew = main.userViewModelNew {
    let newId = Unmanaged.passUnretained(userViewModelNew).toOpaque()
    print("new user refId: \(newId)")
}

if let apiClient = main.apiClient {
    apiClient.fetchData()
} else {
    print("no instance api client")
}

print("finished")





