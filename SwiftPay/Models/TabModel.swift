//
//  TabModel.swift
//  SwiftPay
//
//  Created by Hadid Hardiansyah Saputra on 18/03/25.
//

import Foundation

enum TabModel: String, CaseIterable {
    case home = "Home"
    case activity = "Activity"
    case wallet = "Wallet"
    case profile = "Profile"
    
    var imagePath: String {
        switch self {
        case .home:
            return "home_icon"
        case .activity:
            return "activity_icon"
        case .wallet:
            return "wallet_icon"
        case .profile:
            return "profile_icon"
        }
    }
    
    var index: Int {
        return TabModel.allCases.firstIndex(of: self) ?? 0
    }
}
