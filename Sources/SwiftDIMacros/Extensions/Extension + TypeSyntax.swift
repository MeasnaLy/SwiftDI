//
//  File.swift
//  
//
//  Created by Measna on 24/12/23.
//

import Foundation
import SwiftSyntax

extension TypeSyntax {
    var autoValue : Any {
        if let type = KeywordType.init(rawValue: self.description.trim) {
            return type.defaultValue
        }
        return "\"\""
    }
}
