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
    case `String` = "String"
    case `Double` = "Double"
    case `Float` = "Float"
    
    var defaultValue: Any {
        switch self {
        case .Int:
            return 0
        case .Double, .Float:
            return 0.0
        default:
            return "\"\""
        }
    }
}
