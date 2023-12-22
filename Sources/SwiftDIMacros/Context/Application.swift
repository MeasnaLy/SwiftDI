//
//  File.swift
//  
//
//  Created by Measna on 20/12/23.
//

import Foundation

public class Application {
    public static let shared = Application()
    private var appContext: AppContext?
    
    private init() {}
    
    public func startNewContext(package: String) -> AppContext {
        appContext = AppContext(packageName: package)
        print("start new Context")
        return appContext!
    }
    
    public func getContext() -> AppContext? {
        return appContext
    }
}
