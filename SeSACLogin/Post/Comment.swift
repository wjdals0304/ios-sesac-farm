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
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, comment, user
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
