//
//  File.swift
//  
//
//  Created by Measna on 21/12/23.
//

import SwiftSyntax

extension DeclGroupSyntax {
    
    var toClassDecl: ClassDeclSyntax? {
        self.as(ClassDeclSyntax.self)
    }
    
    var isStruct: Bool {
        self.as(StructDeclSyntax.self) != nil
    }
    
    var isClass: Bool {
        self.toClassDecl != nil
    }
    
    var name: String? {
        asProtocol(NamedDeclSyntax.self)?.name.text
    }
    
    var diVariables: [DIVariable] {
        guard let classDecl = self.toClassDecl else {
            return []
        }
        
        let variableDecls = classDecl.memberBlock.members.compactMap { $0.decl.as(VariableDeclSyntax.self) }
        
        return variableDecls.compactMap {
            let item = $0.bindings.first
            let modifiers = $0.modifiers.map { $0.name.text }
            let specifier = $0.bindingSpecifier.text
            let name = item!.pattern
            let type = item?.typeAnnotation?.type
            let value = item?.initializer
            
            let diVariable  = DIVariable(modifiers: modifiers, specifier: specifier, name: name, type: type, value: value)
            
            return diVariable
        }
    }
    
    
}
