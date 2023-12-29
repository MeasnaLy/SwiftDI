//
//  File.swift
//  
//
//  Created by Measna on 27/12/23.
//

import Foundation

@propertyWrapper public struct Inject<Value : InitializerDI> {
    public var wrappedValue: Value? {
        get {
            guard let context = ApplicationContext.shared.getContext() else {
                return nil
            }
            
            let className = String(describing: Value.self)
            
            if type == .context {
                guard let instance:Value = context.getInstance(key: className) else {
                    return nil
                }
                return instance
            } else {
                return context.createNewInstance(Value.self) as? Value
            }
        }
    }
    var type: InjectType = .context
    
    public init(_ type: InjectType) {
        self.type = type
    }
}

public enum InjectType {
    case new
    case context
}

