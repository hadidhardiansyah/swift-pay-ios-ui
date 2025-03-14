//
//  AuthRequestModel.swift
//  SwiftPay
//
//  Created by Hadid Hardiansyah Saputra on 03/03/25.
//

import Foundation

struct RegisterRequestModel: Codable {
    let firstName: String
    let lastName: String
    let phoneNumber: String
    let username: String
    let email: String
    let password: String
}

struct LoginRequestModel: Codable {
    let usernameOrEmail: String
    let password: String
}
