//
//  PostViewModal.swift
//  SeSACLogin
//
//  Created by 김정민 on 2022/01/05.
//

import Foundation


class PostViewModel {
        

    var post: Observable<Post> = Observable(Post(id: 0, text: "", user: User(jwt: "", user: UserClass(id: 0, username: "", email: "")), createdAt: "", updatedAt: "", comments: []))
    
    func getPost() {
        
        APIServicePost.getPost { postData, error in
            print("postdata")
            print(postData)
            
//            guard let postData = postData else {
//                return
//            }
//            self.post.value = postData

        }
    }
    
}
