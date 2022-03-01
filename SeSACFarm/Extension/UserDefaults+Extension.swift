//
//  UserDefaults+Extension.swift
//  SeSACFarm
//
//  Created by 김정민 on 2022/03/01.
//

import Foundation

@propertyWrapper
struct UserDefault<Value> {
    let key: String
    let defaultValue: Value
    var container: UserDefaults = .standard
    var wrappedValue: Value {
        get { return container.object(forKey: key) as? Value ?? defaultValue }
        set { container.set(newValue, forKey: key) }
    }
}

extension UserDefaults {
    @UserDefault(key: "token", defaultValue: "")
    static var token: String
    @UserDefault(key: "nickname", defaultValue: "")
    static var nickname: String
    @UserDefault(key: "id", defaultValue: 0)
    static var id: Int
    @UserDefault(key: "email", defaultValue: "")
    static var email: String
}
