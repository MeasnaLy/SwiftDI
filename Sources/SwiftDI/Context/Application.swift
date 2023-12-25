//
//  File.swift
//  
//
//  Created by Measna on 20/12/23.
//

import Foundation
import SwiftDIMacros

extension Notification.Name {
    static let sharedNotification = Notification.Name("com.example.sharedNotification")
}

public class Application {
    public static let shared = Application()
    private var appContext: AppContext?
    private var classes: [String] = []
    
    private init() {}
    
    public func startNewContext(package: String) {
        appContext = AppContext(packageName: package)
    }
    
    public func printTest() {
        self.appContext!.printMap()
    }
    
    public func addClass(_ name: String) {
        self.classes.append(name)
    }
    
    public func setClasses(_ names: [String]) {
        self.classes.append(contentsOf: names)
    }
    
    public func createClass() {
        self.appContext!.createClass(self.classes)
    }
    
    public func getInstance(name: String) -> Any? {
        return self.appContext!.getInstance(name: name)
    }
}
