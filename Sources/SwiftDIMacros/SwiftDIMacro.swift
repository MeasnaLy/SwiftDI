
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import SwiftDiagnostics
import Foundation

private var allClassWithComponets:Set<String> = []
private var allProtocolWithContracts:Set<String> = []

public struct ComponentMacros: MemberMacro {
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
        
        if let className = declaration.name {
            allClassWithComponets.insert(("\(className).self"))
        }
        
        return [DeclSyntax(initializer)]
    }
}

extension ComponentMacros: ExtensionMacro {
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
                let type = diVariable.typeToString
                var memberStr = "let \(name): \(type)"
                
                let isOptional = diVariable.isOptional
                
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

public struct ContractMacros: MemberMacro {
    public static func expansion(of node: SwiftSyntax.AttributeSyntax, providingMembersOf declaration: some SwiftSyntax.DeclGroupSyntax, in context: some SwiftSyntaxMacros.MacroExpansionContext) throws -> [SwiftSyntax.DeclSyntax] {
        
        guard let protocolDecl = declaration.toProtocolDecl else {
            context.diagnose(
                Diagnostic(
                    node: Syntax(node),
                    message: SwiftDIDiagnostic.mustBeProtocol)
            )
            return []
        }
        
        if protocolDecl.attributeStrings.first(where: {$0 == "objc"}) == nil {
            context.diagnose(
                Diagnostic(
                    node: Syntax(node),
                    message: SwiftDIDiagnostic.mustBeProtocol)
            )
            return []
        }
        
        if let protocolName = declaration.name {
            allProtocolWithContracts.insert(("\(protocolName).self"))
        }
        
        return []
    }
}

public struct EnableConfigurationMacros: MemberMacro {
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
        
        if classDecl.inheritanceClauses.first(where: { $0 == "UIApplicationDelegate" }) == nil {
            context.diagnose(
                Diagnostic(
                    node: Syntax(node),
                    message: SwiftDIDiagnostic.mustBeConformToUIApplicationDelegate)
            )
            return []
        }
        
        guard let applicationDidFinishLaunchingWithOptions = classDecl.diFunctions.first(where: { $0 == DIFunction.applicationDidFinishLaunchingWithOptions }) else {
            context.diagnose(
                Diagnostic(
                    node: Syntax(node),
                    message: SwiftDIDiagnostic.missingImplementation)
            )
            return []
        }
        
        let isMacroConfigContextExist = applicationDidFinishLaunchingWithOptions.statemets.first(where: { $0.contains("#ConfigContext") }) != nil
        
        if !isMacroConfigContextExist {
            context.diagnose(
                Diagnostic(
                    node: Syntax(node),
                    message: SwiftDIDiagnostic.mustHaveMaroConfigContext)
            )
            return []
        }
    
        return []
    }
}

extension EnableConfigurationMacros: ExtensionMacro {
    public static func expansion(of node: SwiftSyntax.AttributeSyntax, attachedTo declaration: some SwiftSyntax.DeclGroupSyntax, providingExtensionsOf type: some SwiftSyntax.TypeSyntaxProtocol, conformingTo protocols: [SwiftSyntax.TypeSyntax], in context: some SwiftSyntaxMacros.MacroExpansionContext) throws -> [SwiftSyntax.ExtensionDeclSyntax] {
        
        let syntax: DeclSyntax = """
        extension \(raw: declaration.name!): ConfigureDI {

        }
        """
        
        return [syntax.cast(ExtensionDeclSyntax.self)]
    }
}

public struct ConfigContextMacros : ExpressionMacro {
    public static func expansion(of node: some SwiftSyntax.FreestandingMacroExpansionSyntax, in context: some SwiftSyntaxMacros.MacroExpansionContext) throws -> SwiftSyntax.ExprSyntax {
        
        let codeExpr: ExprSyntax = "ApplicationContext.shared.startContext(classes: [\(raw: allClassWithComponets.joined(separator: ","))], protocols: [\(raw: allProtocolWithContracts.joined(separator: ","))])"
        
        return codeExpr.trimmed
        
    }
}


