//
//  File.swift
//  
//
//  Created by Measna on 21/12/23.
//

import SwiftSyntax

struct ArgumentItem {
    let label: String
    let value: String
}

extension AttributeSyntax {
    var firstArgument: ArgumentItem? {
        if case let .argumentList(item) = arguments {
            let label = item.first?.label?.description.removeQuotes ?? ""
            let value = item.first?.expression.description.removeQuotes ?? ""
           
            return ArgumentItem(label: label, value: value)
        }
        
        return nil
    }
}


