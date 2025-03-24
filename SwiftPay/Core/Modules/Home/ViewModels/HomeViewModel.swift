//
//  HomeViewModel.swift
//  SwiftPay
//
//  Created by Hadid Hardiansyah Saputra on 24/03/25.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    @Published var walletData: WalletModel?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let walletService = WalletService()
    
    func getWallet() {
        walletData = nil
        isLoading = true
        
        walletService.fetchWalletData { [ weak self ] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                
                switch result {
                case .success(let wallet):
                    self?.walletData = wallet
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}

