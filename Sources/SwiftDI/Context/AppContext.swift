//
//  File.swift
//  
//
//  Created by Measna on 20/12/23.
//

import Foundation

public class AppContext {
    
    private var mapKeyInstance: [String: Any] = [:]
    private var mapKeyType: [String: InitializerDI.Type] = [:]
    private var mapKeyProtocol: [String: Protocol] = [:]
    
    private var classes: [InitializerDI.Type] = []
    
    init(classes: [InitializerDI.Type], protocols: [Protocol] = []) {
        self.createClass(classes: classes)
        self.createProtocols(protocols: protocols)
    }
    
    private func createClass(classes: [InitializerDI.Type]) {
        
        for item in classes {
            let className = String(describing: item)
//            print("className: \(className)")
            let classInstance = item.createInstace()
            
            mapKeyInstance[className] = classInstance
            mapKeyType[className] = item
        }
    }
    
    private func createProtocols(protocols: [Protocol]) {
        for item in protocols {
            let protocolName = String(NSStringFromProtocol(item).split(separator: ".").last ?? "")
            //String(describing: item)
//            print("protocolName: \(protocolName)")
            mapKeyProtocol[protocolName] = item
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
    
    // only for package use
    func getInstance(classNameOrProtocol: String) -> Any? {
        
//        print("classNameOrProtocol: \(classNameOrProtocol)")
        
        if let instance = self.mapKeyInstance[classNameOrProtocol] {
            return instance
        }
        
        if let key = checkIfClassNameIsProtocolAndReturnKeySubClassName(classNameOrProtocol) {
            let instance = self.mapKeyInstance[key]!
            return instance
        }
    
        return nil
    }
    
//    public func createNewInstance(_ classType: InitializerDI.Type) -> InitializerDI {
//        return classType.createInstace()
//    }
    
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
