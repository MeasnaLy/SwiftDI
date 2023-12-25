//
//  File.swift
//  
//
//  Created by Measna on 25/12/23.
//

import SwiftSyntax

extension VariableDeclSyntax {
    
    var diVariable: DIVariable {
        let attributes = self.attributes.map {
            if let item = $0.as(AttributeSyntax.self) {
                return item.name
            }
            return ""
        }
        let item = self.bindings.first
        let modifiers = self.modifiers.map { $0.name.text }
        let specifier = self.bindingSpecifier.text
        let name = item!.pattern
        let type = item?.typeAnnotation?.type
        let value = item?.initializer
        let accessorBlock = item?.accessorBlock
        
        let diVariable  = DIVariable(attributes: attributes, modifiers: modifiers, specifier: specifier, name: name, type: type, value: value, accessorBlock: accessorBlock)
        
        return diVariable
    }
}
