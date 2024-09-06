//
//  AuthViewModel.swift
//  RosentalApp
//
//  Created by Lukman Makhaev on 05.09.2024.
//

import Foundation
import Combine

class AuthViewModel {
    var isAuthenticated = false
    
    func login(username: String, password: String) async throws {
        let base64LoginString = "\(username):\(password)"
            .data(using: .utf8)?
            .base64EncodedString() ?? ""
        
        let url = URL(string: "https://test.rozentalgroup.ru/version2/entry.php")!
        
        let loginParameters = [
            "service[0][name]": "login",
            "service[0][attributes][login]": username,
            "service[0][attributes][password]": password,
            "service[1][name]": "customer_navbar"
        ]
        
        let data = try await sendRequest(parameters: loginParameters, url: url, base64: base64LoginString)
        
        do {
            let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
            
            if loginResponse.login == "ok" {
                self.isAuthenticated = true
            }
            
            print("Login status: \(loginResponse.login), Code: \(loginResponse.code)")
            loginResponse.customerNavbar.forEach {
                print("Menu item: \($0.name) - Action: \($0.action)")
            }
        } catch {
            print("Decoding error: \(error.localizedDescription)")
            if let response = String(data: data, encoding: .utf8) {
                print("Raw Response: \(response)")
            }
        }
    }
    
    func sendRequest(parameters: [String: String], url: URL, base64: String) async throws -> Data {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let boundary = "Boundary-\(UUID().uuidString)"
        request.addValue("Basic \(base64)", forHTTPHeaderField: "Authorization")
        request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.httpBody = createMultipartBody(parameters: parameters, boundary: boundary)
        
        let (data, _) = try await URLSession.shared.data(for: request)
        return data
    }
    
    func createMultipartBody(parameters: [String: String], boundary: String) -> Data {
        var body = Data()
        
        for (key, value) in parameters {
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
            body.append("\(value)\r\n".data(using: .utf8)!)
        }
        
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        return body
    }
}
