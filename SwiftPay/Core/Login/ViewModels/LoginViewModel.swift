//
//  LoginViewModel.swift
//  SwiftPay
//
//  Created by Hadid Hardiansyah Saputra on 04/03/25.
//

import Foundation
import SwiftUI

class LoginViewModel: ObservableObject {
    
    private let authService = AuthService()
    
    @Published var selectedOption: LoginOption = .email
    
    enum LoginOption {
        case email
        case phoneNumber
    }
    
    func login(formVM: LoginFormViewModel) {
        let usernameOrEmail = selectedOption == .email ? formVM.email : formVM.phoneNumber
        let user = LoginRequestModel(usernameOrEmail: usernameOrEmail.lowercased(), password: formVM.password)
        
        authService.login(user: user) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    AuthViewModel.shared.setAuthenticated(true)
                case .failure(let error):
                    let errorMessage = (error as? APIError)?.message ?? error.localizedDescription
                    AuthViewModel.shared.setErrorMessage(errorMessage, "login")
                }
            }
        }
    }
    
    
    
}
