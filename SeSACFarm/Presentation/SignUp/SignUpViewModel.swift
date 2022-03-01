//
//  SignUpViewModal.swift
//  SeSACLogin
//
//  Created by 김정민 on 2022/01/04.
//

import Foundation

class SignUpViewModel {
    var email: Observable<String> = Observable("")
    var username: Observable<String> = Observable("")
    var password: Observable<String> = Observable("")
    
    func fetchSignUpAPI(completion: @escaping() -> Void ) {
        
        APIServiceUser.signup(username: self.username.value, email: self.email.value, password: self.password.value) { userData, error in

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
