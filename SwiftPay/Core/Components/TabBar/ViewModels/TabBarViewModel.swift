//
//  TabBarViewModel.swift
//  SwiftPay
//
//  Created by Hadid Hardiansyah Saputra on 18/03/25.
//

import Foundation

class TabBarViewModel: ObservableObject {
    
    @Published var activeTab: TabModel = .home
    @Published var tabShapePosition: CGPoint = .zero
    
    let homeViewModel = HomeViewModel()
    
    func updateTabPosition(_ position: CGPoint) {
        tabShapePosition = position
    }
    
    func switchTab(to tab: TabModel) {
        print("Switching tab to: \(tab)")
        activeTab = tab
        if tab == .home {
            homeViewModel.getWallet()
        }
    }
    
}
