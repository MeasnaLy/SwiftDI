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
    <li>`@Contract` uses only with @objc protocol </li>
    <li>`@Component` uses only with class</li>
    <li>
        `@Inject` uses only with property. The property must be optional and non-static/class. `@Inject` has 2 optional arguments:
        <ul>
            <li>
            <b>type</b>: InjectType.context for getting an existing instance in context (default). InjectType.new for getting a new instance. 
            </li>
            <li>
            <b>qualifier</b>: Specify which type of instance you want. If you don't specify, the first one from the context will be used.  
            </li>
        </ul>
    </li>
    <li>
    `@EnableConfiguration` uses only with the class that conforms to protocol `UIApplicationDelegate` which is normally called the `AppDelegate` class.
    </li>
    <li>
    `#ConfigContext` uses only in the override method of `UIApplicationDelegate` which is `func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: ...`
    </li>
</ul>
<h2>Installation</h2>

```
https://github.com/MeasnaLazi/SwiftD
```
<h2>Example</h2>

<h3>ViewController</h3>

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

<h3>Repository</h3>

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

<h3>Service</h3>

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
<p>I want to make it simple by just `@EnableConfiguration` and `#ConfigContext` without `var classes and protocols` but sadly I can not control the priority execution of macros. So I only let you configure manually like the above instruction. let's see the next update of Swift Macros, I will keep trying to change it to auto-configure. </p>
