//
//  String + Validate.swift
//  Quill
//
//  Created by Casper Daris on 09/09/2023.
//

import Foundation

extension String {
    
    var isValidEmail: Bool {
        NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}").evaluate(with: self)
    }
    
    var isValidUsername: Bool {
        NSPredicate(format: "SELF MATCHES %@", "^[a-zA-Z0-9]{2,18}$").evaluate(with: self)
    }
    
    var isValidPassword: Bool {
        NSPredicate(format: "SELF MATCHES %@", "\\w{6,24}").evaluate(with: self)
    }
}
