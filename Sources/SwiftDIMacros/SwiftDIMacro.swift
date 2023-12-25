
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import SwiftDiagnostics
import Foundation

//private var diContext: AppContext?
extension Notification.Name {
    static let sharedNotification = Notification.Name("com.example.sharedNotification")
}

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
        
        
        return []
    }
}

public struct ComponentDIMacros: MemberMacro {
    public static func expansion(of node: SwiftSyntax.AttributeSyntax,
                                 providingMembersOf declaration: some SwiftSyntax.DeclGroupSyntax,
                                 in context: some SwiftSyntaxMacros.MacroExpansionContext) throws -> [SwiftSyntax.DeclSyntax] {
        
        guard let classDecl = declaration.toClassDecl else {
            context.diagnose(
                Diagnostic(
                    node: Syntax(node),
                    message: SwiftDIDiagnostic.mustBeClass)
            )
            return []
        }
        
        let variables = classDecl.diVariables
        
        if let _ = variables.first(where: { $0.type == nil }) {
            context.diagnose(
                Diagnostic(
                    node: Syntax(node),
                    message: SwiftDIDiagnostic.mustHaveType)
            )
            return []
        }
        
        let initializer = try InitializerDeclSyntax(Utils.generateInitialCode(initCode: "required init", variables: variables)) {
            for diVariable in variables {
                if diVariable.isNeedInitiazer {
                    let name = diVariable.name.trimmed
                    ExprSyntax("self.\(raw: name) = \(raw: name)")
                }
            }
        }
        
        return [DeclSyntax(initializer)]
    }
}

extension ComponentDIMacros: ExtensionMacro {
    public static func expansion(of node: SwiftSyntax.AttributeSyntax, attachedTo declaration: some SwiftSyntax.DeclGroupSyntax, providingExtensionsOf type: some SwiftSyntax.TypeSyntaxProtocol, conformingTo protocols: [SwiftSyntax.TypeSyntax], in context: some SwiftSyntaxMacros.MacroExpansionContext) throws -> [SwiftSyntax.ExtensionDeclSyntax] {
        
        guard let classDecl = declaration.toClassDecl else {
            context.diagnose(
                Diagnostic(
                    node: Syntax(node),
                    message: SwiftDIDiagnostic.mustBeClass)
            )
            return []
        }
        
        let variables = classDecl.diVariables
        
        if let _ = variables.first(where: { $0.type == nil }) {
            context.diagnose(
                Diagnostic(
                    node: Syntax(node),
                    message: SwiftDIDiagnostic.mustHaveType)
            )
            return []
        }
        
        var memberBlockStr = ""
        var variableStr = ""
        
        for diVariable in variables {
            if diVariable.isNeedInitiazer {
                let name = diVariable.name.trimmed
                let type = diVariable.type?.description.trim ?? ""
                var memberStr = "let \(name): \(type)"
                
                let isOptional = type.contains("?")
                
                if let value = diVariable.value {
                    memberStr += " \(value)"
                } else if isOptional {
                    memberStr += " = nil"
                } else {
                    memberStr += " = \(String(describing: diVariable.type?.autoValue ?? ""))"
                }
                variableStr += "\(name): \(name), "
                memberBlockStr.append("\(memberStr)\n")
            }
        }
        
        variableStr = String(variableStr.dropLast(2))
        let syntax: DeclSyntax = """
        extension \(raw: declaration.name!): InitializerDI {
            static func createInstace() -> InitializerDI {
                \(raw: memberBlockStr)
                return self.init(\(raw: variableStr))
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
