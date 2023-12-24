//
//  File.swift
//  
//
//  Created by Measna on 21/12/23.
//

import Foundation

public protocol InitializerDI {
//    init?(_ instances: InitializerDI...)
//    func getInstance<T>(_ type: T.Type) -> T?
    static func createInstace() -> InitializerDI
//    init()
}

public extension InitializerDI {
//    func getInstance<T>(_ type: T.Type) -> T? {
//        if let context = Application.shared.getContext() {
//            for (_, instance) in context.map {
//                if let instance = instance as? T {
//                    return instance
//                }
//            }
//        }
//        
//        return nil
//    }
    
//    func printHi() {
//        print("hi from InitializerDI")
//    }
    
//    init(defaultValues: Bool) {
//          // Define your default values or initialization logic here
//          self.init()
//      }
}
