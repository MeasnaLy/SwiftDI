
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import SwiftDiagnostics
import Foundation

private var diContext: AppContext?

public struct ApplicationDIMacros: MemberMacro {
    public static func expansion(of node: SwiftSyntax.AttributeSyntax,
                                 providingMembersOf declaration: some SwiftSyntax.DeclGroupSyntax,
                                 in context: some SwiftSyntaxMacros.MacroExpansionContext) throws -> [SwiftSyntax.DeclSyntax] {
        
        guard declaration.isClass else {
            context.diagnose(
                Diagnostic(
                    node: Syntax(node),
                    message: SwiftDIDiagnostic.mustBeClass)
            )
            return []
        }
       
        guard let argument = node.arguments else {
            fatalError("compiler bug: the macro does not have any arguments")
        }
        
        let packageName = String(describing: argument)
        print("packageName: \(packageName)")
        
        diContext = Application.shared.startNewContext(package: packageName)
        
        return []
    }
}

public struct ComponentDIMacros: MemberMacro {
    public static func expansion(of node: SwiftSyntax.AttributeSyntax,
                                 providingMembersOf declaration: some SwiftSyntax.DeclGroupSyntax,
                                 in context: some SwiftSyntaxMacros.MacroExpansionContext) throws -> [SwiftSyntax.DeclSyntax] {
        
        guard declaration.isClass else {
            context.diagnose(
                Diagnostic(
                    node: Syntax(node),
                    message: SwiftDIDiagnostic.mustBeClass)
            )
            return []
        }

        let className = "\(diContext?.packageName ?? "").\(declaration.name!)"
        print("className: \(className)")
        if let classType = NSClassFromString(className) as? InitializerDI.Type {
            var classInstance = classType.init()
            if let argumentItem = node.firstArgument {
                if argumentItem.value == "" {
                    // error
                }
                diContext?.addInstance(name: argumentItem.value, instance: classInstance)
            }

        } else {
            print("class not found!")
        }
            
   

        
       
        
        return []
    }
}

extension ComponentDIMacros: ExtensionMacro {
    public static func expansion(of node: SwiftSyntax.AttributeSyntax, attachedTo declaration: some SwiftSyntax.DeclGroupSyntax, providingExtensionsOf type: some SwiftSyntax.TypeSyntaxProtocol, conformingTo protocols: [SwiftSyntax.TypeSyntax], in context: some SwiftSyntaxMacros.MacroExpansionContext) throws -> [SwiftSyntax.ExtensionDeclSyntax] {
        
        guard declaration.isClass else {
            context.diagnose(
                Diagnostic(
                    node: Syntax(node),
                    message: SwiftDIDiagnostic.mustBeClass)
            )
            return []
        }
        
        let syntax: DeclSyntax = """
        extension \(raw: declaration.name!): InitializerDI {
            required init(_ instances: InitializerDI...) {
                
            }
        }
        """
        
        return [syntax.cast(ExtensionDeclSyntax.self)]
    }
}

public struct InjectClassMaros: PeerMacro {
    public static func expansion(of node: SwiftSyntax.AttributeSyntax, providingPeersOf declaration: some SwiftSyntax.DeclSyntaxProtocol, in context: some SwiftSyntaxMacros.MacroExpansionContext) throws -> [SwiftSyntax.DeclSyntax] {
        
        guard var varDecl = declaration.as(VariableDeclSyntax.self) else {
            context.diagnose(
                Diagnostic(
                    node: Syntax(node),
                    message: SwiftDIDiagnostic.mustBeClass)
            )
            return []
        }
        let key = varDecl.bindingSpecifier.text
        let pattern = varDecl.bindings.first?.pattern.description ?? ""
        let typeName = varDecl.bindings.first?.typeAnnotation?.type.description ?? ""
        let typeNamee = typeName.filter { $0 != "?" }
        print("typeName: \(typeName)")
        return ["\(raw: key) \(raw: pattern): \(raw: typeName) { \(raw: typeNamee).getInstance(\(raw: typeNamee).self) }"]
    }
}
