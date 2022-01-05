//
//  APIServicePost.swift
//  SeSACLogin
//
//  Created by 김정민 on 2022/01/05.
//


import Foundation


class APIServicePost {
    
    static func getPost( completion: @escaping ([Post?],APIError?) -> Void) {
    
        let url = URL(string: "http://test.monocoding.com:1231/posts")!
    
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        // string -> data,  dictionary -> Jsonserialization / codable
        let jwt = UserDefaults.standard.object(forKey: "token") as! String
        print("jwt")
        print("Bearer " + jwt)
        request.addValue("Bearer " + jwt, forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard error == nil else {
                completion([],.failed)
                return
            }
            
            guard let data = data else {
                completion([],.noData)
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion([],.invalidResponse)
                return
            }
 
            guard response.statusCode == 200 else {
                completion([],.failed)
                return
            }

            do {
                let decoder = JSONDecoder()
                let postData = try decoder.decode([Post].self, from: data)
                print("post")
                completion(postData,nil)
            } catch let error {
                print("Got an error: \(error)")
                completion([],.invalidData)
            }
            
            
        }.resume()
    }

    
}

