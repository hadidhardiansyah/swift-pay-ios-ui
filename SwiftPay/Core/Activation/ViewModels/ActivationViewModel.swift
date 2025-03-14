//
//  ActivationViewModel.swift
//  SwiftPay
//
//  Created by Hadid Hardiansyah Saputra on 07/03/25.
//

import Foundation

class ActivationViewModel: ObservableObject {
    
    @Published var enterValue: [String] {
        didSet {
            canProceed = !enterValue.contains { $0.isEmpty }
        }
    }
    @Published var focusedField: Int?
    @Published var canProceed: Bool = false
    @Published var errorMessage: Bool = false
    
    private let authService = AuthService()
    
    let numberOfFields: Int
    
    init(numberOfFields: Int) {
        self.numberOfFields = numberOfFields
        self.enterValue = Array(repeating: "", count: numberOfFields)
        self.focusedField = 0
    }
    
    func updateValue(index: Int, newValue: String) {
        enterValue[index] = newValue.filter { $0.isNumber }.prefix(1).description
        
        if !enterValue[index].isEmpty, index < numberOfFields - 1 {
            focusedField = index + 1
        }
    }
    
    
    func activateAccount(token: String) {
        AuthViewModel.shared.setLoading(true)
        
        authService.activateAccount(token: token) { result in
            DispatchQueue.main.async {
                AuthViewModel.shared.setLoading(false)
                
                switch result {
                case .success(_):
                    AuthViewModel.shared.setActivated(true)
                case .failure(let error):
                    let errorMessage = (error as? APIError)?.message ?? error.localizedDescription
                    print(errorMessage)
                    AuthViewModel.shared.setErrorMessage(errorMessage, "activation")
                }
            }
        }
    }
    
}
