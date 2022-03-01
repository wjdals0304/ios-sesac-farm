//
//  APIError.swift
//  SeSACFarm
//
//  Created by 김정민 on 2022/03/01.
//

import Foundation


enum APIError: Error {
    case invalidResponse
    case noData
    case failed
    case invalidData
}
