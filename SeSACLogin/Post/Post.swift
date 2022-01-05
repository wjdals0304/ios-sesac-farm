//
//  Post.swift
//  SeSACLogin
//
//  Created by 김정민 on 2022/01/05.
//

import Foundation

// MARK: - PostElement
struct Post: Codable {
    let id: Int
    let text: String
    let user: User
    let createdAt, updatedAt: String
    let comments: [Comment]


}

// MARK: - Comment
struct Comment: Codable {
    let id: Int
    let comment: String
    let user, post: Int
    let createdAt, updatedAt: String

}
