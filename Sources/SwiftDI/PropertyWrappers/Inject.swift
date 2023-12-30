//
//  File.swift
//  
//
//  Created by Measna on 27/12/23.
//

import Foundation

// Old Logic
//@propertyWrapper public struct Inject<Value : InitializerDI> {
//    public var wrappedValue: Value? {
//        get {
//            var className = String(describing: Value.self)
//            
//            if let qualifier = qualifier {
//                className = String(describing: qualifier.self)
//            }
//            
//            guard let context = ApplicationContext.shared.getContext() else {
//                return nil
//            }
//            
//            switch type {
//            case .context:
//                guard let instance:Value = context.getInstance(className: className) else {
//                    return nil
//                }
//                return instance
//            case .new:
//                return context.createNewInstance(className) as? Value
//            }
//        }
//    }
//    var type: InjectType = .context
//    var qualifier: InitializerDI.Type?
//    
//    public init(_ type: InjectType, qualifier: InitializerDI.Type? = nil) {
//        self.type = type
//        self.qualifier = qualifier
//    }
//}

public enum InjectType {
    case new
    case context
}

@propertyWrapper public struct Inject<Value> {
    public var wrappedValue: Value? {
        get {
            var className = String(describing: Value.self)
            
            if let qualifier = qualifier {
                className = String(describing: qualifier.self)
            }
            
            guard let context = ApplicationContext.shared.getContext() else {
                return nil
            }
       
            switch type {
            case .context:
                guard let instance = context.getInstanceProtocol(className: className) else {
                    return nil
                }
                return instance as? Value
            case .new:
                return context.createNewInstance(className) as? Value
            }
        }
    }
    var type: InjectType
    var qualifier: InitializerDI.Type?
    
    public init(_ type: InjectType = .context, qualifier: InitializerDI.Type? = nil) {
        self.type = type
        self.qualifier = qualifier
    }
}

