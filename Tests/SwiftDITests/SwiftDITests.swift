import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

// Macro implementations build for the host, so the corresponding module is not available when cross-compiling. Cross-compiled tests may still make use of the macro itself in end-to-end tests.
#if canImport(SwiftDIMacros)
import SwiftDIMacros

let testMacros: [String: Macro.Type] = [
//    "ApplicationDI" : ApplicationDIMacros.self,
    "Component" : ComponentMacros.self,
//    "InjectClass": InjectClassMaros.self
    
]
#endif

final class SwiftDITests: XCTestCase {
    
//    func testMacroApplicationDI() {
//        assertMacroExpansion(
//            """
//            @ApplicationDI("SwiftDITests.SwiftDITests")
//            class Application {
//            }
//            """,
//            expandedSource:"""
//            
//            class Application {
//            }
//            """,
//            macros: testMacros)
//    }
    
    func testMacroComponent() {
        assertMacroExpansion(
            """
            @Component
            class Service {
            }
            """,
            expandedSource:"""
            
            class Service {
            
                required init() {
                }
            }
            
            extension Service: InitializerDI {
                static func createInstace() -> InitializerDI {
                     return self.init()
                }
            }
            """,
            macros: testMacros)
    }
    
    func testMacroComponentDIWithVariable() {
        assertMacroExpansion(
            """
            @Component
            class Service {
                private static var age: Int = 0
                private let age: Int = 0
                let id: Int
                private var name: String
                var gender: String = "male"
                var node: String?
            }
            """,
            expandedSource:"""
            
            class Service {
                private static var age: Int = 0
                private let age: Int = 0
                let id: Int
                private var name: String
                var gender: String = "male"
                var node: String?
            
                required init(id: Int, name: String, gender: String, node: String?) {
                    self.id = id
                    self.name = name
                    self.gender = gender
                    self.node = node
                }
            }
            
            extension Service: InitializerDI {
                static func createInstace() -> InitializerDI {
                    let id: Int = 0
                    let name: String = ""
                    let gender: String = "male"
                    let node: String? = nil
            
                    return self.init(id: id, name: name, gender: gender, node: node)
                }
            }
            """,
            macros: testMacros)
    }
    
//    func testInjectClass() {
//        assertMacroExpansion(
//            """
//            class Service {
//                @InjectClass
//                var test: Test?
//                private var name: String
//            }
//            """,
//            expandedSource:"""
//            
//            class Service {
//                var test: Test? {
//                    get {
//                        guard let context = Application.shared.getContext() else {
//                            return nil
//                        }
//                        guard let instance: Test = context.getInstance(key: "Test") else {
//                            return nil
//                        }
//                        return instance
//                    }
//                }
//                private var name: String
//            }
//            
//            """,
//            macros: testMacros)
//    }
    
    func testInjectClassWithArgument() {
        assertMacroExpansion(
            """
            @Component
            class Service {
                @Inject(.new)
                var test: Test?
            
                @Inject(.context)
                var test1: Test?
            }
            """,
            expandedSource:"""
            
            class Service {
                var test: Test? {
                    get {
                        guard let context = Application.shared.getContext() else {
                            return nil
                        }
                        guard let instance: Test = context.getInstance(key: "Test") else {
                            return nil
                        }
                        return instance
                    }
                }
                private var name: String
            }
            
            """,
            macros: testMacros)
    }
}
