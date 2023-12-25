//
//  File.swift
//  
//
//  Created by Measna on 24/12/23.
//

import Foundation
import SwiftSyntax
import SwiftSyntaxBuilder

struct Utils {
    public static func generateInitialCode(initCode: String, variables: [DIVariable]) -> SyntaxNodeString {
        var initialCode: String = initCode + "("
        for diVariable in variables {
            let name = diVariable.name?.description.trim ?? ""
            let type = diVariable.type?.description.trim ?? ""
            initialCode += "\(name): \(type), "
        }
        initialCode = String(initialCode.dropLast(2))
        initialCode += ")"
        return SyntaxNodeString(stringLiteral: initialCode)
    }
}
