//
//  File.swift
//  
//
//  Created by Measna on 28/12/23.
//

import SwiftSyntax

extension FunctionDeclSyntax {
    var diFunction: DIFunction {
        let attributes = self.attributes.map {
            if let item = $0.as(AttributeSyntax.self) {
                return item.name
            }
            return ""
        }
//        let modifiers = self.modifiers.map { $0.name.text }
//        let specifier = self.bindingSpecifier.text
        let name = self.name.description
//        let type = item?.typeAnnotation?.type
//        let value = item?.initializer
//        let accessorBlock = item?.accessorBlock
        
        let diFunction  = DIFunction(attributes: attributes, name: name)
        
        return diFunction
    }
}
