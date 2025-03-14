//
//  RegistrationViewModel.swift
//  SwiftPay
//
//  Created by Hadid Hardiansyah Saputra on 06/03/25.
//

import Foundation

class RegistrationViewModel: ObservableObject {
    
    private let authService = AuthService()
    
    func register(formVM: RegistrationFormViewModel) {
        AuthViewModel.shared.setLoading(true)
        
        let newUser = RegisterRequestModel(
            firstName: formVM.firstName,
            lastName: formVM.lastName,
            phoneNumber: formVM.phoneNumber,
            username: formVM.username.lowercased(),
            email: formVM.email.lowercased(),
            password: formVM.password
        )
        
        authService.register(user: newUser) { result in
            DispatchQueue.main.async {
                AuthViewModel.shared.setLoading(false)
                
                switch result {
                case .success(_):
                    AuthViewModel.shared.setRegistered(true)
                case .failure(let error):
                    let errorMessage = (error as? APIError)?.message ?? error.localizedDescription
                    AuthViewModel.shared.setErrorMessage(errorMessage, "registration")
                }
            }
        }
    }
    
}
