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
    
    
    
}
