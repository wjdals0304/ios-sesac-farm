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
            UserDefaults.standard.set(userData.jwt , forKey: "token")
            UserDefaults.standard.set(userData.user.username , forKey: "nickname")
            UserDefaults.standard.set(userData.user.id , forKey: "id")
            UserDefaults.standard.set(userData.user.email , forKey: "email")
            
            completion()
        }
    }
    
    
    
    
}
