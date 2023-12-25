//
//  File.swift
//  
//
//  Created by Measna on 21/12/23.
//

import Foundation

extension String {
    var removeQuotes: String {
        filter { $0 != "\"" }
    }
    
    var trim: String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
