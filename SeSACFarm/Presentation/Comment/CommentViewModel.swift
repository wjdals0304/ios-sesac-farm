//
//  CommentViewModel.swift
//  SeSACLogin
//
//  Created by 김정민 on 2022/01/10.
//

import Foundation


class CommentViewModel {
    
    var comment: Observable<[CommentElement]> = Observable([CommentElement(id: 0, comment: "", user: PostUser(id: 0, username: "", email: "", provider: "", confirmed: true, blocked: true, role: 0, createdAt: "", updatedAt: ""), post: PostComment(id: 0, text: "", user: 0, createdAt: "", updatedAt: ""), createdAt: "", updatedAt: "")])
    
    var commentElement: Observable<CommentElement> = Observable(CommentElement(id: 0, comment: "", user: PostUser(id: 0, username: "", email: "", provider: "", confirmed: true, blocked: true, role: 0, createdAt: "", updatedAt: ""), post:PostComment(id: 0, text: "", user: 0, createdAt: "", updatedAt: ""), createdAt: "", updatedAt: ""))
    
    func getComment(id: String, completion: @escaping( [CommentElement] ) -> Void) {
        
        APIServiceComment.getComment(id: id) { response, error in
            self.comment.value = response
            completion(self.comment.value)
        }
    }
    
    func saveComment(id: String, comment: String, completion: @escaping( CommentElement ) -> Void) {
        
        APIServiceComment.saveComment(id: id, comment: comment) { response, error in
            
            guard let response = response else {
                return
            }
            
            self.commentElement.value = response
            completion(self.commentElement.value)
        }
        
    }
    func updateComment( commentId: String, postId: String, comment: String, completion: @escaping(CommentElement) -> Void) {
        APIServiceComment.updateComment(commentId: commentId, postId: postId, comment: comment) { response, error in

            guard let response = response else {
                return
            }

            self.commentElement.value = response
            completion(self.commentElement.value)
        }
    }
    
    func deleteComment(commentId: String, completion: @escaping(CommentElement) -> Void) {
        APIServiceComment.deleteComment(commentId: commentId) { response, error in
            guard let response = response else {
                return
            }

            self.commentElement.value = response
            completion(self.commentElement.value)
        }
    }
}
