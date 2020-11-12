//
//  CloudCommunicator.swift
//  Arcade Hoops
//
//  Created by Samuel Donovan on 11/10/20.
//

import Foundation

struct UserData: Codable {
    let username: String
    let password: String
}

struct SuccessResponse: Codable {
    let success: Bool
}

struct UserScore: Codable {
    let score: Int
    let username: String
}

class CloudCommunicator {
    
    static let decoder = JSONDecoder()
    static let encoder = JSONEncoder()
    
    static let urlComponents: URLComponents = {
        var urlComponents = URLComponents()
        urlComponents.host = "www.google.com"
        urlComponents.port = 80
        urlComponents.scheme = "http"
        return urlComponents
    }()
    
    static func attemptLogin(username: String, password: String, goodLogin: @escaping () -> (), networkFailure: @escaping () -> (), badLogin: @escaping () -> ()) {
        var urlComponents = Self.urlComponents
        urlComponents.queryItems = [.init(name: "attemptLogin", value: "true")]
        let url = urlComponents.url!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.httpBody = try! encoder.encode(UserData(username: username, password: password))
        
        let dataTask = URLSession.shared.dataTask(with: request) {(data: Data?, response: URLResponse?, error: Error?) in
            guard let data = data, let response = response as? HTTPURLResponse, (200..<300).contains(response.statusCode), error == nil else {networkFailure(); return}
            
            guard let successResponse = try? decoder.decode(SuccessResponse.self, from: data) else {
                print(String(data: data, encoding: .utf8) ?? "HTTP RESPONSE BODY NOT VALID UTF-8 STRING")
                fatalError("HTTP response body not decodable as SuccessResponse")
            }

            if successResponse.success {
                goodLogin()
            } else {
                badLogin()
            }
        }
        dataTask.resume()
    }
    
    static func getHighScores(uponSuccess: @escaping ([UserScore]) -> (), networkFailure: @escaping () -> ()) {
        var urlComponents = Self.urlComponents
        urlComponents.queryItems = [.init(name: "attemptLogin", value: "false")]
        let url = urlComponents.url!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(with: request) {(data: Data?, response: URLResponse?, error: Error?) in
            guard let data = data, let response = response as? HTTPURLResponse, (200..<300).contains(response.statusCode), error == nil else {networkFailure(); return}
            
            guard let userScores = try? decoder.decode([UserScore].self, from: data) else {
                print(String(data: data, encoding: .utf8) ?? "HTTP RESPONSE BODY NOT VALID UTF-8 STRING")
                fatalError("HTTP response body not decodable as SuccessResponse")
            }
            
            uponSuccess(userScores)
        }
        dataTask.resume()
        
    }
    
    static func postScore(username: String, score: Int, anyFailure: @escaping () -> ()) {
        var urlComponents = Self.urlComponents
        urlComponents.queryItems = [.init(name: "createUser", value: "false")]
        let url = urlComponents.url!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try! encoder.encode(UserScore(score: score, username: username))
        
        let dataTask = URLSession.shared.dataTask(with: request) {(data: Data?, response: URLResponse?, error: Error?) in
            guard let data = data, let response = response as? HTTPURLResponse, (200..<300).contains(response.statusCode), error == nil else {anyFailure(); return}
            
            guard let successResponse = try? decoder.decode(SuccessResponse.self, from: data) else {
                print(String(data: data, encoding: .utf8) ?? "HTTP RESPONSE BODY NOT VALID UTF-8 STRING")
                fatalError("HTTP response body not decodable as SuccessResponse")
            }
            
            if !successResponse.success {anyFailure()}
        }
        dataTask.resume()
    }
    
    static func createUser(username: String, password: String, networkFailure: @escaping () -> (), badAttempt: @escaping () -> (), goodAttempt: @escaping () -> ()) {
        var urlComponents = Self.urlComponents
        urlComponents.queryItems = [.init(name: "createUser", value: "true")]
        let url = urlComponents.url!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try! encoder.encode(UserData(username: username, password: password))
        
        
        let dataTask = URLSession.shared.dataTask(with: request) {(data: Data?, response: URLResponse?, error: Error?) in
            guard let data = data, let response = response as? HTTPURLResponse, (200..<300).contains(response.statusCode), error == nil else {networkFailure(); return}
            
            guard let successResponse = try? decoder.decode(SuccessResponse.self, from: data) else {
                print(String(data: data, encoding: .utf8) ?? "HTTP RESPONSE BODY NOT VALID UTF-8 STRING")
                fatalError("HTTP response body not decodable as SuccessResponse")
            }
            
            if successResponse.success {
                goodAttempt()
            } else {
                badAttempt()
            }
        }
        dataTask.resume()
    }
}
