<h1>SwiftDI (Swift Dependency Injection)</h1>

Most Swift Dependency Injection frameworks are factory patterns. They don't work like Java (Spring Dependency Injection). I don't like it. I see Swift Macro can create annotations like Java. 
I want to try it out if I can do something with Swift Macro to be like Spring Dependency Injection worked.

<h2>Purpose</h2>
I want to make SwiftDI work like Spring Dependency Injection that uses annotation.

<h2>Todo</h2>
<ul>
  <li>Create Context ✅</li>
  <li>Create Annotation @Component for class ✅</li>
  <li>Create Annotation @InjectClass for variable ✅</li>
  <li>Create Argument for @InjectClass(.new or .context)</li>
  <li>Create Annotation @Qualifier for variable</li>
  <li>Consider working with struct</li>
  <li>Create a Life Cycle Event</li>
  <li>Create a Profile (eg: Mock vs Original)</li>
  <li>more...etc</li>
</ul>

<h2>Code</h2>

```
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
```

