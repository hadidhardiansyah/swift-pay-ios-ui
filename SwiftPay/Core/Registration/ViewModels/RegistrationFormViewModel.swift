//
//  RegisterFormViewModel.swift
//  SwiftPay
//
//  Created by Hadid Hardiansyah Saputra on 06/03/25.
//

import Foundation

class RegistrationFormViewModel: ObservableObject {
    
    @Published var firstName: String = ""
    
    @Published var lastName: String = ""
    
    @Published var phoneNumber: String = ""
    
    @Published var username: String = ""
    
    @Published var email: String = "" {
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
