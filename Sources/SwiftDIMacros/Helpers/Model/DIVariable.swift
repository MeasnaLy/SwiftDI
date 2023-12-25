//
//  File.swift
//  
//
//  Created by Measna on 24/12/23.
//

import SwiftSyntax
import SwiftSyntaxBuilder

struct DIVariable {
    let modifiers: [String]
    let specifier: String
    let name: PatternSyntax
    let type: TypeSyntax?
    let value: InitializerClauseSyntax?
    let accessorBlock: AccessorBlockSyntax?
    
    var isNeedInitiazer: Bool {
        
        let isStatic = modifiers.first {
            $0 == Keyword.static.rawValue } != nil
        if isStatic {
            return false
        }
        
        let isLet = specifier == Keyword.let.rawValue
        if isLet && value != nil {
            return false
        }
        
        let isVar = specifier == Keyword.var.rawValue
        if isVar && accessorBlock != nil {
            return false
        }
        
        return true
    }
    
    var isOptional: Bool {
        if let typeDesciption = type?.description.trim {
            return typeDesciption.contains("?")
        }
        return false
    }
    
    var typeToString: String {
        type?.description.trim ?? ""
    }
}
