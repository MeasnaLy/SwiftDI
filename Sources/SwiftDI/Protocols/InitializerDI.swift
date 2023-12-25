//
//  File.swift
//  
//
//  Created by Measna on 21/12/23.
//

import Foundation

public protocol InitializerDI {
//    init?(_ instances: InitializerDI...)
    static func createInstace() -> InitializerDI
//    init()
    func getInstance<T : InitializerDI>(_ type: T.Type) -> T?
}

public extension InitializerDI {
    func getInstance<T : InitializerDI>(_ type: T.Type) -> T? {
        let key = NSStringFromClass(type as! AnyClass)
        if let context = Application.shared.getContext() {
            if let instance:T = context.getInstance(key: key) {
                return instance
            }
        }
        
        return nil
    }
}
