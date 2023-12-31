// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

@attached(extension, conformances: InitializerDI, names: arbitrary)
@attached(member, names: named(init))
public macro Component() = #externalMacro(module: "SwiftDIMacros", type: "ComponentMacros")

@attached(member)
public macro Contract() = #externalMacro(module: "SwiftDIMacros", type: "ContractMacros")

@attached(extension, conformances: ConfigureDI, names: arbitrary)
@attached(member)
public macro EnableConfiguration() = #externalMacro(module: "SwiftDIMacros", type: "EnableConfigurationMacros")

@freestanding(expression)
public macro ConfigContext() -> AppContext = #externalMacro(module: "SwiftDIMacros", type: "ConfigContextMacros")
