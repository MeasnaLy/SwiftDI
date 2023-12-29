//
//  File.swift
//  
//
//  Created by Measna on 29/12/23.
//

import SwiftSyntax

struct DIParamater : Equatable {
    let firstName: String
    let secondName: String
    
    static func == (lhs: DIParamater, rhs: DIParamater) -> Bool {
        return lhs.firstName == rhs.firstName && rhs.secondName == rhs.secondName
    }
}
