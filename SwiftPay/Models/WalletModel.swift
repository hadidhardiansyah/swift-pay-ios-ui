//
//  WalletModel.swift
//  SwiftPay
//
//  Created by Hadid Hardiansyah Saputra on 24/03/25.
//

import Foundation

struct WalletModel: Codable {
    let id: Int
    let user: UserModel
    let balance: Double
    let createdAt: String
}
