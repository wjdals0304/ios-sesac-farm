//
//  APIServiceComment.swift
//  SeSACLogin
//
//  Created by 김정민 on 2022/01/10.
//

import Foundation

class APIServiceComment {
    static func getComment(id: String, completion: @escaping ([CommentElement], APIError?) -> Void) {
        let param = "post=\(id)"
        let paramData = param.data(using: .utf8)
        var request = URLRequest(url: CommentUrlEndpoint.getComment.url)
        request.httpMethod = "GET"
        request.httpBody = paramData
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
                let commentData = try decoder.decode([CommentElement].self, from: data)
                    completion(commentData, nil)
            } catch let error {
                print("Got an error: \(error)")
                completion([], .invalidData)
            }
        }.resume()
    }

    static func saveComment(id: String, comment: String, completion: @escaping (CommentElement?, APIError?) -> Void) {
        let param =  "post=\(id)&comment=\(comment)"
        let paramData = param.data(using: .utf8)
        var request = URLRequest(url: CommentUrlEndpoint.saveComment.url)
        request.httpMethod = "POST"
        request.httpBody = paramData
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
                let commentData = try decoder.decode(CommentElement.self, from: data)
                    completion(commentData, nil)
            } catch let error {
                print("Got an error: \(error)")
                completion(nil, .invalidData)
            }
        }.resume()
    }
    static func updateComment(commentId: String, postId: String, comment: String, completion: @escaping (CommentElement?, APIError?) -> Void) {
        let param =  "post=\(postId)&comment=\(comment)"
        let paramData = param.data(using: .utf8)
        var request = URLRequest(url: CommentUrlEndpoint.updateComment(id: commentId).url)
        request.httpMethod = "PUT"
        request.httpBody = paramData
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
                let commentData = try decoder.decode(CommentElement.self, from: data)
                    completion(commentData, nil)
            } catch let error {
                print("Got an error: \(error)")
                completion(nil, .invalidData)
            }
        }.resume()
    }
    static func deleteComment(commentId: String, completion: @escaping (CommentElement?, APIError?) -> Void) {

        var request = URLRequest(url: CommentUrlEndpoint.deleteComment(id: commentId).url)
        request.httpMethod = "DELETE"
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
                let commentData = try decoder.decode(CommentElement.self, from: data)
                    completion(commentData, nil)
            } catch let error {
                print("Got an error: \(error)")
                completion(nil, .invalidData)
            }
        }.resume()
    }
}
