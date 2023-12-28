// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

//@attached(member)
//public macro ApplicationDI(_ packageName: String) = #externalMacro(module: "SwiftDIMacros", type: "ApplicationDIMacros")

@attached(extension, conformances: InitializerDI, names: arbitrary)
@attached(member, names: named(init))
public macro Component() = #externalMacro(module: "SwiftDIMacros", type: "ComponentMacros")

//@attached(peer)
//public macro InjectClass() = #externalMacro(module: "SwiftDIMacros", type: "InjectClassMaros")

//@attached(accessor)
//public macro InjectClass() = #externalMacro(module: "SwiftDIMacros", type: "InjectClassMaros")
