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
    case invalidVariableInjectClass
    
    var severity: DiagnosticSeverity {
        return .error
    }
    
    var message: String {
        switch self {
        case .mustBeClass:
            return "`@ComponentDI` can only applied to a `class`"
        case .mustHaveType:
            return "All variables in @ComponentDI must have `Type`"
        case .mustBeOptional:
            return "All variables in @ComponentDI must be `Optional`"
        case .invalidVariableInjectClass:
            return "InjectClass variables invalid format"
        }
    }
    var  diagnosticID: MessageID {
        .init(domain: "codes.measnalazi", id: rawValue)
    }
}
