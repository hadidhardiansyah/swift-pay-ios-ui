//
//  BACKUP.swift
//  SwiftPay
//
//  Created by Hadid Hardiansyah Saputra on 08/03/25.
//

import Foundation

class backupService {
    private let baseUrl = "http://192.168.18.105:8080/api/v1/auth"
    
    func register(user: RegisterRequestModel, completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: "\(baseUrl)/register") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let jsonData = try? JSONEncoder().encode(user)
        request.httpBody = jsonData

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            completion(.success("Registrasi berhasil, cek email untuk aktivasi"))
        }.resume()
    }
    
    func activateAccount(token: String, completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: "\(baseUrl)/activate-account?token=\(token)") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { _, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(APIError(message: "Invalid response from server")))
                return
            }
            print(response ?? "HADID")
            if (200...299).contains(httpResponse.statusCode) {
                completion(.success("Akun berhasil diaktivasi! Silakan login."))
            } else {
                completion(.failure(APIError(message: "Aktivasi gagal, coba lagi nanti.")))
            }
        }.resume()
    }
}
