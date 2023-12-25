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
    
    init(classes: [InitializerDI.Type]) {
        self.classes = classes
        self.createClass()
    }
    
    func addInstance(name: String, instance: InitializerDI) {
        self.mapKeyInstance[name] = instance
    }
    
    func createClass() {
        
        for item in self.classes {
            let className = String(describing: item)
            let classInstance = item.createInstace()
            mapKeyInstance[className] = classInstance

            
//            let className = String(describing: item)
//            
//            if let classType = NSClassFromString(className) as? InitializerDI.Type {
//                let classInstance = classType.createInstace()
//                mapKeyInstance[className] = classInstance
//    
//            } else {
//                print("class not found: \(className)")
//            }
        }
    }
    
    public func getInstance(key: String) -> Any? {
        return self.mapKeyInstance[key]
    }
    
    func printMap() {
        print("map: \(self.mapKeyInstance)")
    }
}
