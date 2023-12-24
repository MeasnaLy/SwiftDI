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
    
    public func startNewContext(package: String) -> AppContext {
        appContext = AppContext(packageName: package)
        print("start new Context")

        if let sharedData = UserDefaults.standard.string(forKey: "sharedKey") {
            print("Shared Data: \(sharedData)")
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification), name: .sharedNotification, object: nil)
        
        return appContext!
    }
    
    public func getContext() -> AppContext? {
        return appContext
    }
    
    public func printTest() {
        self.appContext!.printMap()
    }
    
    public func addClass(_ name: String) {
        self.classes.append(name)
    }
    
    public func createClass() {
        self.appContext!.createClass(self.classes)
    }
    
    @objc func handleNotification(_ notification: Notification) {
        print("Received notification in Project 2")
        if let value = notification.userInfo?["key"] as? String {
            print("Received notification with value: \(value)")
        }
    }
}
