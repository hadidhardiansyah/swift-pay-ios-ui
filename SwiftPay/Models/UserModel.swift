//
//  User.swift
//  SwiftPay
//
//  Created by Hadid Hardiansyah Saputra on 03/03/25.
//

import Foundation

struct UserModel: Codable {
    let id: Int
    let firstName: String
    let lastName: String
    let phoneNumber: String
    let username: String
    let email: String
    let enabled: Bool
}
