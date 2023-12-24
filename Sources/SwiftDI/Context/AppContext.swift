//
//  File.swift
//  
//
//  Created by Measna on 20/12/23.
//

import Foundation

public class AppContext {
    
    var map: [String: Any] = [:]
    var packageName: String = ""
    
    init(packageName: String) {
        self.packageName = "SwiftDIClient"//packageName.replacingOccurrences(of: "\"", with: "")
    }
    
    func addInstance(name: String, instance: InitializerDI) {
        self.map[name] = instance
    }
    
    func createClass(_ classess: [String]) {
        
        for className in classess {
            if let classType = NSClassFromString(className) as? InitializerDI.Type {
                let classInstance = classType.createInstace()
                map[className] = classInstance
    
            } else {
                print("class not found!")
            }
        }
    }
    
    func printMap() {
        print("map: \(self.map)")
    }
}
