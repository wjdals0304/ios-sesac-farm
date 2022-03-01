//
//  CommentEndPoint.swift
//  SeSACFarm
//
//  Created by 김정민 on 2022/03/01.
//

import Foundation

enum CommentUrlEndpoint {
    case getComment(id: String)
    case saveComment
    case updateComment(id: String)
    case deleteComment(id: String)
}

extension CommentUrlEndpoint {
    var url: URL {
        switch self {
        case .getComment(id: let id): return .makeEndpoint("/comments?post=\(id)")
        case .saveComment : return .makeEndpoint("/comments")
        case .updateComment(id: let id) : return .makeEndpoint("/comments/\(id)")
        case .deleteComment(id: let id) : return .makeEndpoint("/comments/\(id)")
        }
    }
}
