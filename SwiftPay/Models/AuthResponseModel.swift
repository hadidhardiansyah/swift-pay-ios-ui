//
//  AuthResponseModel.swift
//  SwiftPay
//
//  Created by Hadid Hardiansyah Saputra on 03/03/25.
//

import Foundation

struct RegisterResponseModel: Codable {
    let message: String
    let status: String
}

struct LoginResponseModel: Codable {
    let token: String
    let status: String
}

struct ErrorResponseModel: Codable {
    let businessErrorCode: Int
    let businessErrorDescription: String
}
