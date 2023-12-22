//
//  File.swift
//  
//
//  Created by Measna on 21/12/23.
//

import SwiftSyntax

extension DeclGroupSyntax {
    var isStruct: Bool {
        self.as(StructDeclSyntax.self) != nil
    }
    
    var isClass: Bool {
        self.as(ClassDeclSyntax.self) != nil
    }
    
    var name: String? {
        asProtocol(NamedDeclSyntax.self)?.name.text
    }
    
    
}
