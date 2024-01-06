<h1>SwiftDI (Swift Dependency Injection)</h1>

Most Swift Dependency Injection frameworks are factory patterns. They don't work like Java (Spring Dependency Injection). I don't like it. I see Swift Macro can create annotations like Java. 
I want to try it out if I can do something with Swift Macro to be like Spring Dependency Injection worked.

<h2>Purpose</h2>
I want to make SwiftDI work like Spring Dependency Injection that uses annotation.

<h2>Todo</h2>
<ul>
    <li>Create Context ✅</li>
    <li>Create Annotation @Component for class ✅</li>
    <li>Create Annotation @Inject for properties ✅</li>
    <li>Create Argument for @Inject(.new or .context) with qualifier✅</li>
    <li>Consider working with struct</li>
    <li>Create a Life Cycle Event</li>
    <li>Create a Profile (eg: Mock vs Original)</li>
    <li>more...etc</li>
</ul>

<h2>How to use:</h2>
<ul>
    <li>@Contract uses only with @objc protocol </li>
    <li>@Component uses only with class</li>
    <li>
        @Inject uses only with property. The property must be optional and non static/class. @Inject has 2 optional arguments:
        <ol>
            <li>
            type: InjectType.context for getting an existing instance in context (default). InjectType.new for getting a new instance. 
            </li>
            <li>
            qualifier: Specify which type of instance you want. If you don't specify, the first one from the context will be used.  
            </li>
        </ol>
    </li>
    <li>
    @EnableConfiguration
    \#ConfigContext
    </li>
</ul>
<h3>Example</h3>


<p>ViewController</p>
```
import SwiftDI

class ViewController: UIViewController {
    
    @Inject(.context, qualifier: Const().isTesting ? UserServiceMock.self : UserServiceImpl.self)
    var userService: UserService?
    
    @Inject(.context, qualifier: UserServiceImpl.self)
    var userServiceContext: UserService?
    
    @Inject(.new)
    var userServiceNew: UserService?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let userService = self.userService {
            print("==userService==")
            userService.showCurrentUser()
        }
        
        if let userServiceContext = self.userServiceContext {
            print("==userServiceContext==")
            userServiceContext.showCurrentUser()
        }
        
        if let userServiceNew = self.userServiceNew {
            print("==userServiceNew==")
            userServiceNew.showCurrentUser()
        }
    }
}
```

<p>Repository</p>
```
import SwiftDI

@Contract
@objc protocol UserRepository {
    func getCurrentUser()
}

@Component
class UserRepositoryImpl: UserRepository {
    
    func getCurrentUser() {
        print("UserRepositoryImpl getCurrentUser called!")
    }
}

@Component
class UserRepositoryMock: UserRepository {
    
    func getCurrentUser() {
        print("UserRepositoryMock getCurrentUser called!")
    }
}
```

<p>Service</p>
```
import SwiftDI

@Contract
@objc protocol UserService {
    func showCurrentUser()
}

@Component
class UserServiceImpl: UserService {
    
    @Inject(.context, qualifier: UserRepositoryImpl.self)
    private var userRepository: UserRepository?
    
    func showCurrentUser() {
        print("UserServiceImpl called")
        userRepository?.getCurrentUser()
    }
}

@Component
class UserServiceMock: UserService {
    
    @Inject(.context, qualifier: UserRepositoryMock.self)
    private var userRepository: UserRepository?
    
    func showCurrentUser() {
        print("UserServiceMock called")
        userRepository?.getCurrentUser()
    }
}
```

<h3>Configuration</h3>
```
@EnableConfiguration
class AppDelegate: UIResponder, UIApplicationDelegate {
    var classes: [InitializerDI.Type] {
        [
            UserRepositoryMock.self,
            UserRepositoryImpl.self,
            UserServiceImpl.self,
            UserServiceMock.self,
        ]
    }
    
    var protocols: [Protocol] {
        [
            UserService.self,
            UserRepository.self,
        ]
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let _ = #ConfigContext
        ...
        return true
    }

}
```
<p>I want to make it more simple by just `@EnableConfiguration` and `#ConfigContext` without `var classes and protocols` but sadly I can not control the priority execution of macros. So I only let you configure manually like the above instruction. </p>
