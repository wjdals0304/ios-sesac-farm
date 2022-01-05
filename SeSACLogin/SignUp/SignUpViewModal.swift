//
//  SignUpViewModal.swift
//  SeSACLogin
//
//  Created by 김정민 on 2022/01/04.
//

import Foundation

class SignUpViewModal {
    
    var email: Observable<String> = Observable("")
    var username: Observable<String> = Observable("")
    var password: Observable<String> = Observable("")
    
    
    func fetchSignUpAPI(completion: @escaping() -> Void ){
        
        APIServiceUser.signup(username: self.username.value, email: self.email.value, password: self.password.value) { userData, error in

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
