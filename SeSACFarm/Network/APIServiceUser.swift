//
//  APIService.swift
//  SeSACLogin
//
//  Created by 김정민 on 2022/01/04.
//

import Foundation

class APIServiceUser {
    static func signup(username: String, email: String, password: String, completion: @escaping (User?, APIError?) -> Void) {
        var request = URLRequest(url: UserUrlEndpoint.user_register.url)
        request.httpMethod = "POST"
        request.httpBody = "username=\(username)&email=\(email)&password=\(password)".data(using: .utf8, allowLossyConversion: false)
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                completion(nil, .failed)
                return
            }
            guard let data = data else {
                completion(nil, .noData)
                return
            }
            guard let response = response as? HTTPURLResponse else {
                completion(nil, .invalidResponse)
                return
            }
            guard response.statusCode == 200 else {
                completion(nil, .failed)
                return
            }

            do {
                let decoder = JSONDecoder()
                let userData = try decoder.decode(User.self, from: data)
                completion(userData, nil)
            } catch {
                completion(nil, .invalidData)
            }
        }.resume()
    }
    static func login(identifier: String, password: String, completion: @escaping (User?, APIError?) -> Void) {
        var request = URLRequest(url: UserUrlEndpoint.login.url)
        request.httpMethod = "POST"
        request.httpBody = "identifier=\(identifier)&password=\(password)".data(using: .utf8, allowLossyConversion: false)
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                completion(nil, .failed)
                return
            }
            guard let data = data else {
                completion(nil, .noData)
                return
            }
            guard let response = response as? HTTPURLResponse else {
                completion(nil, .invalidResponse)
                return
            }
            guard response.statusCode == 200 else {
                completion(nil, .failed)
                return
            }

            do {
                let decoder = JSONDecoder()
                let userData = try decoder.decode(User.self, from: data)
                completion(userData, nil)
            } catch {
                completion(nil, .invalidData)
            }
        }.resume()
    }
}
