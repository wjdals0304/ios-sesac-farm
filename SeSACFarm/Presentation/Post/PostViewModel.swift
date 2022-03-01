//
//  PostViewModal.swift
//  SeSACLogin
//
//  Created by 김정민 on 2022/01/05.
//

import Foundation


class PostViewModel {
        
    var post: Observable<[Post]> = Observable([Post(id: 0, text: "", user: PostUser(id: 0, username: "", email: "", provider: "", confirmed: true, blocked: true, role: 0, createdAt: "", updatedAt: ""), createdAt: "", updatedAt: "", comments: [])])
    
    var postElement: Observable<Post> = Observable(Post(id: 0, text: "", user: PostUser(id: 0, username: "", email: "", provider: "", confirmed: true, blocked: true, role: 0, createdAt: "", updatedAt: ""), createdAt: "", updatedAt: "", comments: []))
    
    func getPost(completion: @escaping( [Post] ) -> Void) {
        
        APIServicePost.getPost { response, error in
            self.post.value = response
            completion(self.post.value)
        }
        
    }
    
    func savePost(text: String, completion: @escaping( Post ) -> Void) {
        APIServicePost.savePost(text: text) { response, error in
            
            guard let response = response else {
                return
            }
            
            self.postElement.value = response
            completion(self.postElement.value)
            
        }
    }
    
    func updatePost(id: String, text: String, completion: @escaping( Post ) -> Void ) {
        
        APIServicePost.updatePost(id: id, text: text) { response, error in
            
            guard let response = response else {
                return
            }
            
            self.postElement.value = response
            completion(self.postElement.value)
        }
        
    }
    
    func deletePost(id:String, completion: @escaping( Post ) -> Void ) {
        
        APIServicePost.deletePost(id: id) { response, error in
            
            guard let response = response else {
                return
            }
            
            self.postElement.value = response
            completion(self.postElement.value)

        }
        
    }
    
}
