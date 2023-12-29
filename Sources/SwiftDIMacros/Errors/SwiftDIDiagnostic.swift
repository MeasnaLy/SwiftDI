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
    case mustHaveAttributeConfig
    
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
        case .mustHaveAttributeConfig:
            return "`@EnableConfiguration` must be has attribute `@Config` on Function"
        }
        
    }
    var  diagnosticID: MessageID {
        .init(domain: "codes.measnalazi", id: rawValue)
    }
}
