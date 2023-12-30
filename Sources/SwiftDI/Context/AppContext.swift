//
//  File.swift
//  
//
//  Created by Measna on 20/12/23.
//

import Foundation

public class AppContext {
    
    private var mapKeyInstance: [String: Any] = [:]
    private var classes: [InitializerDI.Type] = []
    private var mapKeyType: [String: InitializerDI.Type] = [:]
    
    public var mapKeyProtocol: [String: Protocol] = [:]
    
    init(classes: [InitializerDI.Type]) {
        self.classes = classes
        self.createClass()
    }
    
    func createClass() {
        
        for item in self.classes {
            let className = String(describing: item)
            let classInstance = item.createInstace()
            
            mapKeyInstance[className] = classInstance
            mapKeyType[className] = item
        }
    }
    
    public func getInstance<T: InitializerDI>(className: String) -> T? {
        if let instance = self.mapKeyInstance[className] {
            return instance as? T
        }
        
        if let key = checkIfClassNameIsProtocolAndReturnKeySubClassName(className) {
            let instance = self.mapKeyInstance[key]!
            return instance as? T
        }
    
        return nil
    }
    
    public func getInstance<T: InitializerDI>(type: InitializerDI.Type) -> T? {
        let className = String(describing: type)
        return getInstance(className: className)
    }
    
    public func getInstanceProtocol(className: String) -> Any? {
        if let instance = self.mapKeyInstance[className] {
            return instance
        }
        
        if let key = checkIfClassNameIsProtocolAndReturnKeySubClassName(className) {
            let instance = self.mapKeyInstance[key]!
            return instance
        }
    
        return nil
    }
    
    public func createNewInstance(_ classType: InitializerDI.Type) -> InitializerDI {
        return classType.createInstace()
    }
    
    public func createNewInstance(_ className: String) -> InitializerDI? {

        if let instance = self.mapKeyType[className] {
            return instance.createInstace()
        }
        
        if let key = checkIfClassNameIsProtocolAndReturnKeySubClassName(className) {
            let instance = self.mapKeyType[key]!
            return instance.createInstace()
        }
        
        return nil
    }
    
    private func checkIfClassNameIsProtocolAndReturnKeySubClassName(_ protocolType: String) -> String? {
        if let typeProtocol = mapKeyProtocol[protocolType] {
            for (key, instance) in self.mapKeyInstance {
                if (instance as AnyObject).conforms(to: typeProtocol) {
                    return key
                }
            }
        }
        
        return nil
    }
    
    
}
