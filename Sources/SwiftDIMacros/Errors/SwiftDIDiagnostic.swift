//
//  File.swift
//  
//
//  Created by Measna on 21/12/23.
//

import SwiftDiagnostics

enum SwiftDIDiagnostic: String, DiagnosticMessage {
    case mustBeClass
    case mustHaveType
    case mustBeOptional
    case mustBeConformToUIApplicationDelegate
    case mustHaveMaroConfigContext
    case mustBeFunction
    case missingImplementation
    case mustBeProtocol
    
    var severity: DiagnosticSeverity {
        return .error
    }
    
    var message: String {
        switch self {
        case .mustBeClass:
            return "`@Component` can only applied to a `class`"
        case .mustHaveType:
            return "All variables in `@Component` must have `Type`"
        case .mustBeOptional:
            return "All variables in `@Component` must be `Optional`"
        case .mustBeConformToUIApplicationDelegate:
            return "`class` must be conform to `UIApplicationDelegate`"
        case .mustHaveMaroConfigContext:
            return "`@EnableConfiguration` must be has macro `#ConfigContext` on Function"
        case .mustBeFunction:
            return "`@Config` only works on functions"
        case .missingImplementation:
            return "`@Component` missing implementation of ApplicationDidFinishLaunchingWithOptions function"
        case .mustBeProtocol:
            return "`@Contract` can only applied to a `@objc protocol`"
        }
        
    }
    var  diagnosticID: MessageID {
        .init(domain: "codes.measnalazi", id: rawValue)
    }
}
