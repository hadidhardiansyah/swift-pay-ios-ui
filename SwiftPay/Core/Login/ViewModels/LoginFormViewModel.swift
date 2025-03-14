//
//  LoginFormViewModel.swift
//  SwiftPay
//
//  Created by Hadid Hardiansyah Saputra on 05/03/25.
//

import Foundation

class LoginFormViewModel: ObservableObject {
    
    @Published var email: String = "" {
        didSet { validateForm() }
    }
    
    @Published var phoneNumber: String = "" {
        didSet { validateForm() }
    }
    
    @Published var password: String = "" {
        didSet { validateForm() }
    }
    
    @Published var canProceed: Bool = false
     
    func validateForm() {
        canProceed = Validator.validateEmail(email) && Validator.validatePassword(password)
    }
    
}
