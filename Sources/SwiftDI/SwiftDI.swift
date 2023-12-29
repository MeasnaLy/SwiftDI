// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

@attached(member)
public macro EnableConfiguration(_ packageName: String) = #externalMacro(module: "SwiftDIMacros", type: "EnableConfigurationMacros")

@attached(extension, conformances: InitializerDI, names: arbitrary)
@attached(member, names: named(init))
public macro Component() = #externalMacro(module: "SwiftDIMacros", type: "ComponentMacros")
