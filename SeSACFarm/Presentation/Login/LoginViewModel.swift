//
//  LoginViewModal.swift
//  SeSACLogin
//
//  Created by 김정민 on 2022/01/04.
//

import Foundation


class LoginViewModel {
    
    var email: Observable<String> = Observable("")
    var password: Observable<String> = Observable("")
    func postUserLogin(completion: @escaping() -> Void) {
        APIServiceUser.login(identifier: email.value, password: password.value) { userData, error in

            guard let userData = userData else {
                return
            }
            UserDefaults.token = userData.jwt
            UserDefaults.nickname = userData.user.username
            UserDefaults.id = userData.user.id
            UserDefaults.email = userData.user.email
            completion()
        }
    }
}
