//
//  File.swift
//  
//
//  Created by Measna on 21/12/23.
//

import SwiftCompilerPlugin
import SwiftSyntaxMacros

@main
struct SwiftDIPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        ComponentMacros.self,
        ConfigContextMacros.self,
        ConfigContextFileMacros.self,
        EnableConfigurationMacros.self,
        ContractMacros.self,
    ]
}
