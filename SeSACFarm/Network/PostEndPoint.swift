//
//  PostEndPoint.swift
//  SeSACFarm
//
//  Created by 김정민 on 2022/03/01.
//

import Foundation

enum PostUrlEndpoint {
    case getPost
    case savePost
    case updatePost(id: String)
    case deletePost(id: String)
}

extension PostUrlEndpoint {
    var url: URL {
        switch self {
        case .getPost : return .makeEndpoint("/posts?_sort=created_at:desc")
        case .savePost : return .makeEndpoint("/posts")
        case .updatePost(id: let id): return .makeEndpoint("/posts/\(id)")
        case .deletePost(id: let id): return .makeEndpoint("/posts/\(id)")
        }
    }
}
