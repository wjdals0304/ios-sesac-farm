//
//  UserEndPoint.swift
//  SeSACFarm
//
//  Created by 김정민 on 2022/03/01.
//

import Foundation

enum UserUrlEndpoint {
    case user_register
    case login
}

extension UserUrlEndpoint {
    var url: URL {
        switch self {
        case .user_register : return .makeEndpoint("/auth/local/register")
        case .login : return .makeEndpoint("/auth/local")
        }
    }
}

extension URL {
    static let baseURL = "http://test.monocoding.com:1231"
    static func makeEndpoint(_ endpoint: String) -> URL {
        return URL(string: baseURL + endpoint)!
    }
}
