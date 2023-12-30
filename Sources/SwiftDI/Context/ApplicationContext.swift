//
//  File.swift
//  
//
//  Created by Measna on 20/12/23.
//

import Foundation
import SwiftDIMacros

public class ApplicationContext {
    public static let shared = ApplicationContext()
    private var appContext: AppContext?
    
    private init() {}
    
    public func startContext(classes: [InitializerDI.Type], protocols: [Protocol] = []) -> AppContext {
        if let appContext {
            return appContext
        }
        appContext = AppContext(classes: classes, protocols: protocols)
        return appContext!
    }
    
    public func getContext() -> AppContext? {
        return self.appContext
    }
}
