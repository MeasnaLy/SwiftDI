//
//  File.swift
//  
//
//  Created by Measna on 21/12/23.
//

import SwiftSyntax

extension AttributeSyntax {
    var firstArgument: DIArgument? {
        if case let .argumentList(item) = arguments {
            let label = item.first?.label?.description.removeQuotes ?? ""
            let value = item.first?.expression.description.removeQuotes ?? ""
           
            return DIArgument(label: label, value: value)
        }
        
        return nil
    }
    
    var name: String {
        String(self.description.trim.dropFirst())
    }
}


