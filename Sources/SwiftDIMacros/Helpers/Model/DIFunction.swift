//
//  File.swift
//  
//
//  Created by Measna on 28/12/23.
//

import SwiftSyntax

struct DIFunction: Equatable {
    let attributes: [String]
    let name: String
    let paramaters: [DIParamater]
    let statemets: [String]
    let returnType: String
    
    static func == (lhs: DIFunction, rhs: DIFunction) -> Bool {
        return lhs.name == rhs.name && lhs.paramaters == rhs.paramaters && lhs.returnType == rhs.returnType
    }
}

extension DIFunction {
    static var applicationDidFinishLaunchingWithOptions: DIFunction {
        let paramaters = [DIParamater(firstName: "_", secondName: "application"), DIParamater(firstName: "didFinishLaunchingWithOptions", secondName: "launchOptions")]
        return DIFunction(attributes: [], name: "application", paramaters: paramaters, statemets:[], returnType: "Bool")
    }
}
