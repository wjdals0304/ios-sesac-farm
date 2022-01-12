//
//  Comment.swift
//  SeSACLogin
//
//  Created by 김정민 on 2022/01/09.
//

import Foundation

// MARK: - CommentElement
struct CommentElement: Codable {
    let id: Int
    let comment: String
    let user: PostUser
    let post: PostComment
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, comment, user, post
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

struct PostComment: Codable {
    let id : Int
    let text : String
    let user: Int
    let createdAt, updatedAt : String
    
    enum CodingKeys: String, CodingKey {
        case id, text, user
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
