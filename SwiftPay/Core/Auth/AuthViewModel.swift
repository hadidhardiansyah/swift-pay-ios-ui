//
//  AuthViewModel.swift
//  SwiftPay
//
//  Created by Hadid Hardiansyah Saputra on 03/03/25.
//

import Foundation

class AuthViewModel: ObservableObject {
    
    @Published var isRegistered = false
    @Published var isActivated = false
    @Published var isAuthenticated = false
    @Published var isLoading = false
    @Published var showActivationErrorAlert = false
    @Published var showLoginErrorAlert = false
    @Published var showRegisterErrorAlert = false
    @Published var activationErrorMessage = ""
    @Published var loginErrorMessage = ""
    @Published var registerErrorMessage = ""
    
    static let shared = AuthViewModel()
    
    init() {}
    
    func setAuthenticated(_ isAuth: Bool) {
        DispatchQueue.main.async {
            self.isAuthenticated = isAuth
        }
    }
    
    func setRegistered(_ isRegist: Bool) {
        DispatchQueue.main.async {
            self.isRegistered = isRegist
        }
    }
    
    func setActivated(_ isActive: Bool) {
        DispatchQueue.main.async {
            self.isActivated = isActive
        }
    }
    
    func setLoading(_ isLoading: Bool) {
        DispatchQueue.main.async {
            self.isLoading = isLoading
        }
    }
    
    func setErrorMessage(_ message: String, _ action: String) {
        DispatchQueue.main.async {
            switch action {
            case "activation":
                self.showActivationErrorAlert = true
                self.activationErrorMessage = message
            case "login":
                self.showLoginErrorAlert = true
                self.loginErrorMessage = message
            case "register":
                self.showRegisterErrorAlert = true
                self.registerErrorMessage = message
            default:
                return
            }
        }
    }
    
    func resetErrorState() {
        self.showActivationErrorAlert = false
        self.showLoginErrorAlert = false
        self.showRegisterErrorAlert = false
        self.activationErrorMessage = ""
        self.loginErrorMessage = ""
        self.registerErrorMessage = ""
    }
    
}
