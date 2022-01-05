//
//  User.swift
//  SeSACLogin
//
//  Created by 김정민 on 2022/01/04.
//

import Foundation

// MARK: - User
struct User: Codable {
    let jwt: String
    let user: UserClass
}

// MARK: - UserClass
struct UserClass: Codable {
    let id: Int
    let username, email: String
}
