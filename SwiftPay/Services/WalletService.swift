//
//  WalletService.swift
//  SwiftPay
//
//  Created by Hadid Hardiansyah Saputra on 24/03/25.
//

import Foundation

class WalletService {
    private let baseUrl = "http://192.168.18.105:8080/api/v1"
    
    @Published var walletData: WalletModel?
    
    // MARK: Get Data Wallet
    func fetchWalletData(completion: @escaping (Result<WalletModel, Error>) -> Void) {
        guard let url = URL(string: "\(baseUrl)/wallet") else { return }
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let token = UserDefaults.standard.string(forKey: "authToken") {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, let data = data else {
                completion(.failure(APIError(message: "Invalid response from server")))
                return
            }
            
            if (200...299).contains(httpResponse.statusCode) {
                do {
                    let walletData = try JSONDecoder().decode(WalletModel.self, from: data)
                    completion(.success(walletData))
                } catch {
                    completion(.failure(APIError(message: "Failed to parse success response")))
                }
            } else if httpResponse.statusCode == 401 {
                completion(.failure(APIError(message: "Unauthorized - Token might be expired")))
            } else {
                do {
                    let errorResponse = try JSONDecoder().decode(ErrorResponseModel.self, from: data)
                    completion(.failure(APIError(message: errorResponse.businessErrorDescription)))
                } catch {
                    let rawResponse = String(data: data, encoding: .utf8) ?? "Invalid Data"
                    completion(.failure(APIError(message: "Failed to parse error response: \(rawResponse)")))
                }
            }
        }.resume()
    }
}
