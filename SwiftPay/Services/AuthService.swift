//
//  AuthService.swift
//  SwiftPay
//
//  Created by Hadid Hardiansyah Saputra on 03/03/25.
//

import Foundation

struct APIError: Error {
    let message: String
    
    var localizedDescription: String {
        return message
    }
}

class AuthService {
    private let baseUrl = "http://192.168.18.105:8080/api/v1/auth"
    
    // MARK: Register
    func register(user: RegisterRequestModel, completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: "\(baseUrl)/register") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONEncoder().encode(user)
            request.httpBody = jsonData
        } catch {
            completion(.failure(APIError(message: "Failed to encode request data")))
            return
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
                    let successResponse = try JSONDecoder().decode(RegisterResponseModel.self, from: data)
                    completion(.success(successResponse.message))
                } catch {
                    completion(.failure(APIError(message: "Failed to parse success response")))
                }
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
    
    // MARK: Activate Account
    func activateAccount(token: String, completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: "\(baseUrl)/activate-account?token=\(token)") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, let data = data else {
                completion(.failure(APIError(message: "Invalid response from server")))
                return
            }
            
            if (200...209).contains(httpResponse.statusCode) {
                do {
                    let successResponse = try JSONDecoder().decode(RegisterResponseModel.self, from: data)
                    completion(.success(successResponse.message))
                } catch {
                    completion(.failure(APIError(message: "Failed to parse success response")))
                }
            } else {
                do {
                    let errorResponse = try JSONDecoder().decode(ErrorResponseModel.self, from: data)
                    completion(.failure(APIError(message: errorResponse.businessErrorDescription)))
                } catch {
                    let rawResponse = String(data: data, encoding: .utf8) ?? "Invalid data"
                    completion(.failure(APIError(message: "Failed to parse error response: \(rawResponse)")))
                }
            }
        }.resume()
    }
    
    
    // MARK: Login
    func login(user: LoginRequestModel, completion: @escaping (Result<LoginResponseModel, Error>) -> Void) {
        guard let url = URL(string: "\(baseUrl)/authenticate") else { return }
        
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
            
            guard let httpResponse = response as? HTTPURLResponse, let data = data else {
                completion(.failure(APIError(message: "Invalid response from server")))
                return
            }
            
            if (200...299).contains(httpResponse.statusCode) {
                do {
                    let authResponse = try JSONDecoder().decode(LoginResponseModel.self, from: data)
                    completion(.success(authResponse))
                } catch {
                    completion(.failure(APIError(message: "Failed to parse success response")))
                }
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
