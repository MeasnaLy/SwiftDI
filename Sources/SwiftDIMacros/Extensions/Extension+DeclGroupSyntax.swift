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
            $0.diVariable
        }
    }
}
