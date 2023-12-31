//
//  File.swift
//  
//
//  Created by Measna on 30/12/23.
//

import Foundation

public protocol ConfigureDI {
    var classes: [InitializerDI.Type] { get }
    var protocols: [Protocol] { get }
}
