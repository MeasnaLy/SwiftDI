//
//  File.swift
//  
//
//  Created by Measna on 21/12/23.
//

import Foundation

class Test {
    var t: Test? { self.getInstance(Test.self) }
    init() {
        
    }
    
    required init(_ instances: InitializerDI...) {
        
    }
}

extension Test : InitializerDI {
    
}
