//
//  LoginViewController.swift
//  SeSACLogin
//
//  Created by 김정민 on 2022/01/03.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {
    
    let viewModel = LoginViewModal()
    
    let emailText : UITextField = {
        let email = UITextField()
        email.placeholder = "이메일 주소"
        email.layer.borderWidth = 1
        return email
    }()
    
    let passwordText : UITextField = {
        let password = UITextField()
        password.placeholder = "비밀번호"
        password.layer.borderWidth = 1
        return password
    }()
    
    let loginButton : UIButton = {
        let button = UIButton()
        button.setTitle("로그인", for: .normal)
        button.backgroundColor = .green
        return button
    }()
    
    let stackView: UIStackView = {
        
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 3
        view.distribution = .fillEqually
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(closeButtonClicked))
        
        emailText.addTarget(self, action: #selector(emailTextFieldDidChange(_:)), for: .editingChanged)
        passwordText.addTarget(self, action: #selector(passwordTextFieldDidChange(_:)), for: .editingChanged)
        loginButton.addTarget(self, action: #selector(loginButtonClicked), for: .touchUpInside)
        
        setupView()
        setUpConstraints()
    }
    
    @objc func closeButtonClicked(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func emailTextFieldDidChange(_ textfield: UITextField){
        viewModel.email.value = textfield.text ?? ""
    }
    
    @objc func passwordTextFieldDidChange(_ textfield: UITextField){
        viewModel.password.value = textfield.text ?? ""
    }
    
    func setupView() {
        self.view.backgroundColor = .white
        
        self.view.addSubview(stackView)
        [emailText,passwordText,loginButton].forEach {
            
            self.stackView.addArrangedSubview($0)
        }
    }
    
    func setUpConstraints(){
        
        self.stackView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(40)
            make.centerX.equalToSuperview()
            make.width.equalTo(self.view.snp.width).multipliedBy(0.8)
            make.height.equalTo(200)
        }
        
    }
    
    
    @objc func loginButtonClicked() {
        
        viewModel.postUserLogin {
                        
            DispatchQueue.main.async {
                let svc = PostViewController()
                let nav = UINavigationController(rootViewController: svc)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        }
    }
    
    
    
    
}
