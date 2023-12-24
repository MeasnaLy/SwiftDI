import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

// Macro implementations build for the host, so the corresponding module is not available when cross-compiling. Cross-compiled tests may still make use of the macro itself in end-to-end tests.
#if canImport(SwiftDIMacros)
import SwiftDIMacros

let testMacros: [String: Macro.Type] = [
    "ApplicationDI" : ApplicationDIMacros.self,
    "ComponentDI" : ComponentDIMacros.self,
    "InjectClass": InjectClassMaros.self
    
]
#endif

final class SwiftDITests: XCTestCase {
    
//    func testMacro() throws {
//        #if canImport(SwiftDIMacros)
//        assertMacroExpansion(
//            """
//            #stringify(a + b)
//            """,
//            expandedSource: """
//            (a + b, "a + b")
//            """,
//            macros: testMacros
//        )
//        #else
//        throw XCTSkip("macros are only supported when running tests for the host platform")
//        #endif
//    }
//
//    func testMacroWithStringLiteral() throws {
//        #if canImport(SwiftDIMacros)
//        assertMacroExpansion(
//            #"""
//            #stringify("Hello, \(name)")
//            """#,
//            expandedSource: #"""
//            ("Hello, \(name)", #""Hello, \(name)""#)
//            """#,
//            macros: testMacros
//        )
//        #else
//        throw XCTSkip("macros are only supported when running tests for the host platform")
//        #endif
//    }
    
    func testMacroApplicationDI() {
        assertMacroExpansion(
            """
            @ApplicationDI("SwiftDITests.SwiftDITests")
            class Application {
            }
            """,
            expandedSource:"""
            
            class Application {
            }
            """,
            macros: testMacros)
    }
    
        func testMacroComponentDI() {
            testMacroApplicationDI()
            assertMacroExpansion(
                """
                @ComponentDI(name: "service")
                class Service {
                }
                """,
                expandedSource:"""
                
                class Service {
                }
                
                extension Service: InitializerDI {
                }
                """,
                macros: testMacros)
            
            
        }
    
    func testInjectClass() {
        assertMacroExpansion(
            """
            class Application {
                @InjectClass
                var test: TestService?
            }
            """,
            expandedSource:"""
            
            class Application {
                var test: TestService = {
            
                }
            }
            """,
            macros: testMacros)
    }
}
