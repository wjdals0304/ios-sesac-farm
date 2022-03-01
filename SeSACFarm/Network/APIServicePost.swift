//
//  APIServicePost.swift
//  SeSACLogin
//
//  Created by 김정민 on 2022/01/05.
//

import Foundation

class APIServicePost {
    
    static func getPost( completion: @escaping ([Post], APIError?) -> Void) {
        var request = URLRequest(url: PostUrlEndpoint.getPost.url)
        request.httpMethod = "GET"
        let jwt = UserDefaults.token
        request.setValue("Bearer " + jwt, forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard error == nil else {
                completion([], .failed)
                return
            }
            
            guard let data = data else {
                completion([], .noData)
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion([], .invalidResponse)
                return
            }
 
            guard response.statusCode == 200 else {
                completion([], .failed)
                return
            }

            do {
                let decoder = JSONDecoder()
                let postData = try decoder.decode([Post].self, from: data)
                    completion(postData, nil)
            } catch let error {
                print("Got an error: \(error)")
                completion([], .invalidData)
            }
        }.resume()
    }
    static func savePost(text: String, completion: @escaping (Post?, APIError?) -> Void) {
        let param =  "text=\(text)"
        let paramData = param.data(using: .utf8)
        var request = URLRequest(url: PostUrlEndpoint.savePost.url)
        request.httpMethod = "POST"
        request.httpBody = paramData
        // string -> data,  dictionary -> Jsonserialization / codable
        let jwt = UserDefaults.token
        request.setValue("Bearer " + jwt, forHTTPHeaderField: "Authorization")
        
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
                let postData = try decoder.decode(Post.self, from: data)
                    completion(postData, nil)
            } catch let error {
                print("Got an error: \(error)")
                completion(nil, .invalidData)
            }
            
        }.resume()
    }

    static func updatePost(id: String, text: String, completion: @escaping (Post?, APIError?) -> Void) {
        let param =  "text=\(text)"
        let paramData = param.data(using: .utf8)
        var request = URLRequest(url: PostUrlEndpoint.updatePost(id: id).url)
        request.httpMethod = "PUT"
        request.httpBody = paramData
        // string -> data,  dictionary -> Jsonserialization / codable
        let jwt = UserDefaults.token
        request.setValue("Bearer " + jwt, forHTTPHeaderField: "Authorization")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
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
                let postData = try decoder.decode(Post.self, from: data)
                    completion(postData, nil)
            } catch let error {
                print("Got an error: \(error)")
                completion(nil, .invalidData)
            }
            
        }.resume()
    }
    static func deletePost(id: String ,completion: @escaping (Post?,APIError?) -> Void) {
        var request = URLRequest(url: PostUrlEndpoint.deletePost(id: id).url)
        request.httpMethod = "DELETE"
        // string -> data,  dictionary -> Jsonserialization / codable
        let jwt = UserDefaults.token
        request.setValue("Bearer " + jwt, forHTTPHeaderField: "Authorization")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
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
                let postData = try decoder.decode(Post.self, from: data)
                    completion(postData, nil)
            } catch let error {
                print("Got an error: \(error)")
                completion(nil, .invalidData)
            }
        }.resume()
    }
}
