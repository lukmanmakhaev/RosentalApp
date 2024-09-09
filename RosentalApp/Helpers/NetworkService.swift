//
//  NetworkService.swift
//  RosentalApp
//
//  Created by Lukman Makhaev on 07.09.2024.
//

import Foundation

final class NetworkService {
    static let shared = NetworkService()
    
    private init() {}
    
    func login(username: String, password: String) async throws -> LoginResponse {
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
        KeychainHelper.save(base64LoginString, forKey: "base64LoginString")
        
        let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
        
        return loginResponse
    }
    
    func getDashboard() async throws -> DashboardResponse {
        // Retrieve the base64LoginString from Keychain
        guard let base64LoginString = KeychainHelper.get("base64LoginString") else {
            throw NSError(domain: "", code: 401, userInfo: [NSLocalizedDescriptionKey: "User not logged in"])
        }
        
        let url = URL(string: "https://test.rozentalgroup.ru/version2/entry.php")!
        
        let dashboardParameters = [
            "service[0][name]": "customer_dashboard",
            "service[1][name]": "my_profile",
            "service[2][name]": "my_new_notifications",
            "service[2][attributes][mode]": "private"
        ]
        
        let data = try await sendRequest(parameters: dashboardParameters, url: url, base64: base64LoginString)
        let dashboardResponse = try JSONDecoder().decode(DashboardResponse.self, from: data)
        
        return dashboardResponse
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
