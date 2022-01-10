//
//  PostViewModal.swift
//  SeSACLogin
//
//  Created by 김정민 on 2022/01/05.
//

import Foundation


class PostViewModel {
        
    var post: Observable<[Post]> = Observable([Post(id: 0, text: "", user: PostUser(id: 0, username: "", email: "", provider: "", confirmed: true, blocked: true, role: 0, createdAt: "", updatedAt: ""), createdAt: "", updatedAt: "", comments: [])])
    
    var comment : Observable<[CommentElement]> = Observable([CommentElement(id: 0, comment: "", user: PostUser(id: 0, username: "", email: "", provider: "", confirmed: true, blocked: true, role: 0, createdAt: "", updatedAt: ""), createdAt: "", updatedAt: "")])
    
    func getPost(completion: @escaping( [Post] ) -> Void) {
        
        APIServicePost.getPost { response , error in
            self.post.value = response
            completion(self.post.value)
        }
        
    }
    
    func getComment(id : String, completion: @escaping( [CommentElement] ) -> Void) {
        
        APIServicePost.getComment(id: id ){ response, error in
            
            self.comment.value = response
            completion(self.comment.value)
        }
    }
    
}

extension PostViewModel {
    
    var numberOFRowInSection: Int {
        return post.value.count
    }
    
    func cellForRowAt(at indexPath: IndexPath) -> Post {
        return post.value[indexPath.row]
    }
    
    
}
