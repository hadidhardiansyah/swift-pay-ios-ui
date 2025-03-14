//
//  Validator.swift
//  SwiftPay
//
//  Created by Hadid Hardiansyah Saputra on 04/03/25.
//

import Foundation

enum Validator {
    static func validateEmail(_ email: String) -> Bool {
        let emailRegex = #"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"#
        
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    static func validatePassword(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$"
        
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordPredicate.evaluate(with: password)
    }
    
    static func validatePhoneNumber(_ phoneNumber: String) -> Bool {
        let phoneRegex = #"^\d{10,13}$"#
        
        let phonePredicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phonePredicate.evaluate(with: phoneNumber)
    }
    
    static func validateSingleDigit(_ value: String) -> Bool {
        return value.count == 1 && value.range(of: #"^\d$"#, options: .regularExpression) != nil
    }
    
}
