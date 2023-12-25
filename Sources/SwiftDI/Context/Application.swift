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
    
    private init() {}
    
    public func startNewContext(classes: [InitializerDI.Type]) -> AppContext {
        appContext = AppContext(classes: classes)
        return appContext!
    }
    
    public func getContext() -> AppContext? {
        return self.appContext
    }
}
