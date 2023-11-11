//
//  Date + Random.swift
//  Quill
//
//  Created by Casper Daris on 14/07/2023.
//

import Foundation

extension Date {
    
    /// Generates a random date value between now and 2001
    static func randomPastDate() -> Date {
        let currentDate = Date()
        let january2001 = Date(timeIntervalSinceReferenceDate: 0)
        
        let randomInterval = TimeInterval.random(in: january2001.timeIntervalSince1970...currentDate.timeIntervalSince1970)
        return Date(timeIntervalSince1970: randomInterval)
    }
}
