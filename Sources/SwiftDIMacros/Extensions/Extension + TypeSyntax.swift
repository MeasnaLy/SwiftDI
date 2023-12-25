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
        
        let type = self.description.trim
        
        if type == "Int" {
            return 0
        } else if type == "Float" || type == "Double" {
            return 0.0
        }
        
        return "\"\""
    }
}
