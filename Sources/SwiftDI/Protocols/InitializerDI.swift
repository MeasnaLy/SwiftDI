//
//  File.swift
//  
//
//  Created by Measna on 21/12/23.
//

import Foundation

public protocol InitializerDI {
    static func createInstace() -> InitializerDI
    func getInstance<T : InitializerDI>(_ type: T.Type) -> T?
}

public extension InitializerDI {
    func getInstance<T : InitializerDI>(_ type: T.Type) -> T? {
        if let context = ApplicationContext.shared.getContext() {
            if let instance:T = context.getInstance(type: type) {
                return instance
            }
        }
        
        return nil
    }
}
