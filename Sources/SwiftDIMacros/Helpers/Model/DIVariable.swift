//
//  File.swift
//  
//
//  Created by Measna on 24/12/23.
//

import SwiftSyntax
import SwiftSyntaxBuilder

struct DIVariable {
    let name: PatternSyntax?
    let type: TypeSyntax?
    let value: InitializerClauseSyntax?
}
