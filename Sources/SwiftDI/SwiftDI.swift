// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

@attached(member)
public macro ApplicationDI(_ packageName: String) = #externalMacro(module: "SwiftDIMacros", type: "ApplicationDIMacros")

@attached(member)
public macro ComponentDI(name: String) = #externalMacro(module: "SwiftDIMacros", type: "ComponentDIMacros")

//@attached(peer)
//public macro InjectClass() = #externalMacro(module: "SwiftDIMacros", type: "InjectClassMaros")

@attached(peer)
public macro InjectClass() = #externalMacro(module: "SwiftDIMacros", type: "InjectClassMaros")
