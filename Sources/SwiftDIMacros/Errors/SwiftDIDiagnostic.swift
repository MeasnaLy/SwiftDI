//
//  File.swift
//  
//
//  Created by Measna on 21/12/23.
//

import SwiftDiagnostics

enum SwiftDIDiagnostic: String, DiagnosticMessage {
    case mustBeClass
    
    var severity: DiagnosticSeverity {
        return .error
    }
    
    var message: String {
        switch self {
        case .mustBeClass:
            return "`@ComponentDI` can only applied to a `class`"
        }
    }
    var  diagnosticID: MessageID {
        .init(domain: "codes.measnalazi", id: rawValue)
    }
}
