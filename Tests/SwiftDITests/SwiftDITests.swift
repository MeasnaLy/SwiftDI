import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

// Macro implementations build for the host, so the corresponding module is not available when cross-compiling. Cross-compiled tests may still make use of the macro itself in end-to-end tests.
#if canImport(SwiftDIMacros)
import SwiftDIMacros

let testMacros: [String: Macro.Type] = [
    "EnableConfiguration" : EnableConfigurationMacros.self,
    "Component" : ComponentMacros.self,
    "ConfigContext": ConfigContextMacros.self,
    "Contract": ContractMacros.self,
    
]
#endif

final class SwiftDITests: XCTestCase {
    
    func testMacroEnableConfiguration() {
        assertMacroExpansion(
            """
            @EnableConfiguration
            class Application : UIApplicationDelegate {
                func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
                    let context = #ConfigContext
                    return true
                }
            }
            """,
            expandedSource:"""
            
            class Application : UIApplicationDelegate {
                func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
                    let context =         ApplicationContext.shared.startContext(classes: classes, protocols: protocols)
                    return true
                }
            }
            
            extension Application: ConfigureDI {

            }
            """,
            macros: testMacros)
    }
    
    func testMacroCofigContext() {
        assertMacroExpansion(
            """
            class Application : UIApplicationDelegate {
                func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
                    let context = #ConfigContext
                    return true
                }
            }
            """,
            expandedSource:"""
            
            class Application : UIApplicationDelegate {
                func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
                    let context =         ApplicationContext.shared.startContext(classes: classes, protocols: protocols)
                    return true
                }
            }
            """,
            macros: testMacros)
    }
    
    func testMacroContract() {
        assertMacroExpansion(
            """
            @Contract
            @objc protocol Service {
            }
            """,
            expandedSource:"""
            
            @objc protocol Service {
            }
            """,
            macros: testMacros)
    }
    
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
}
