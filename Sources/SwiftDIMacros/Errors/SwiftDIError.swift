//
//  File.swift
//  
//
//  Created by Measna on 21/12/23.
//

import SwiftSyntax
import SwiftDiagnostics

private struct ErrorDiagnosticMessage: DiagnosticMessage, Error {
    let message: String
    let diagnosticID: MessageID
    let severity: DiagnosticSeverity
    
    init(id: String, message: String) {
        self.message = message
        self.diagnosticID = MessageID(domain: "codes.measnalazi.swiftdi", id: id)
        self.severity = .error
    }
}
