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
        let name = self.name.description
        let paramaters = self.signature.parameterClause.parameters.map { DIParamater(firstName: $0.firstName.description.trim, secondName: $0.secondName?.description.trim ?? "") }
        let retrunType = self.signature.returnClause?.type.description.trim ?? ""
        
        var statemets:[String] = []
        
        if let body = self.body {
            statemets = body.statements.map { $0.item.description.trim }
        }
        
        
        let diFunction  = DIFunction(attributes: attributes, name: name, paramaters: paramaters, statemets: statemets, returnType: retrunType)
        
        return diFunction
    }
}
