//
//  File.swift
//  
//
//  Created by Measna on 24/12/23.
//

import SwiftSyntax
import SwiftSyntaxBuilder

struct DIVariable {
    let attributes: [String]
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
        
        let isInjectAttribute = attributes.first { $0.hasPrefix("Inject")} != nil
        
        if isInjectAttribute {
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
    
    var typeToStringWithoutOptional: String {
        typeToString.filter { $0 != "?" }
    }
    
    var isValidInjectClass : Bool {
        let isValidAttribute = attributes.first { $0 == "InjectClass"} != nil
        let isValidModifier = modifiers.first { $0 == Keyword.static.rawValue } == nil
        let isValidSpacifier = specifier == Keyword.var.rawValue
        let isValidType = KeywordType(rawValue: typeToString) == KeywordType.Custom
        
        return isValidAttribute && isValidModifier && isValidSpacifier && isValidType && isOptional
    }
    
    var statement: String {
        let modifier = modifiers.joined(separator: " ")
        let value = value != nil ? value?.description : ""
        let accessorBlock = accessorBlock != nil ? accessorBlock?.description : ""
        
        var statement = "\(modifier) \(specifier) \(name.description): \(typeToString)"
        
        if let value = value {
            statement += value
        }
        
        if let accessorBlock = accessorBlock {
            statement += accessorBlock
        }
        
        return statement
    }
    
    
}
