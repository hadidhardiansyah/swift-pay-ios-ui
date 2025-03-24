//
//  Formatter.swift
//  SwiftPay
//
//  Created by Hadid Hardiansyah Saputra on 24/03/25.
//

import Foundation

func formatBalance(_ balance: Double) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.currencyCode = "IDR"
    formatter.maximumFractionDigits = 0
    formatter.locale = Locale(identifier: "id_ID")
    return formatter.string(from: NSNumber(value: balance)) ?? "IDR 0"
}

func formatPhoneNumber(_ phoneNumber: String) -> String {
    let formattedNumber = phoneNumber.replacingOccurrences(of: "(\\d{4})(\\d{4})(\\d{4})", with: "$1-$2-$3", options: .regularExpression)
    return "+62 \(formattedNumber)"
}
