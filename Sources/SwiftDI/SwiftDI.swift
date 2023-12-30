// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

@attached(member)
public macro EnableConfiguration() = #externalMacro(module: "SwiftDIMacros", type: "EnableConfigurationMacros")

@attached(extension, conformances: InitializerDI, names: arbitrary)
@attached(member, names: named(init))
public macro Component() = #externalMacro(module: "SwiftDIMacros", type: "ComponentMacros")

@attached(member)
public macro Contract() = #externalMacro(module: "SwiftDIMacros", type: "ContractMacros")

@freestanding(expression)
public macro ConfigContext() -> AppContext = #externalMacro(module: "SwiftDIMacros", type: "ConfigContextMacros")
