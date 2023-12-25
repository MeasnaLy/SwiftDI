//
//  File.swift
//  
//
//  Created by Measna on 25/12/23.
//

import Foundation

enum Keyword : String {
    case `var` = "var"
    case `static` = "static"
    case `let` = "let"
}

enum KeywordType : String {
    case `Int` = "Int"
    case `UInt` = "UInt"
    case `Float` = "Float"
    case `Double` = "Double"
    case `Bool` = "Bool"
    case `Array` = "Array"
    case `Dictionary` = "Dictionary"
    case `Set` = "Set"
    case `Character` = "Character"
    case `String` = "String"
    case Custom = "Custom"
    
    init?(rawValue: String) {
        switch rawValue {
        case "Int" :
            self = .Int
        case "UInt" :
            self = .UInt
        case "Float" :
            self = .Float
        case "Double" :
            self = .Double
        case "Bool" :
            self = .Bool
        case "Array" :
            self = .Array
        case "Dictionary" :
            self = .Dictionary
        case "Set" :
            self = .Set
        case "Character" :
            self = .Character
        case "String" :
            self = .String
        default:
            self = .Custom
        }
    }
    
    var defaultValue: Any? {
        switch self {
        case .Int, .UInt:
            return 0
        case .Double, .Float:
            return 0.0
        case .Bool:
            return false
        case .Array, .Set:
            return []
        case .Dictionary:
            return [:]
        case .String, .Character:
            return "\"\""
        default:
            return nil
        }
    }
}
