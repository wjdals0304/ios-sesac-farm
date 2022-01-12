//
//  SignUpViewController.swift
//  SeSACLogin
//
//  Created by 김정민 on 2022/01/04.
//

import UIKit

class SignUpViewController: UIViewController {

    let viewModel = SignUpViewModal()
    
    let emailText : UITextField = {
        let email = UITextField()
        email.placeholder = "이메일 주소"
        email.layer.borderWidth = 1
        return email
    }()
    
    let nicknameText : UITextField = {
        let nickname = UITextField()
        nickname.placeholder = "닉네임"
        nickname.layer.borderWidth = 1
        return nickname
    }()
    
    let passwordText : UITextField = {
        let password = UITextField()
        password.placeholder = "비밀번호"
        password.layer.borderWidth = 1
        return password
    }()
    
    let passwordCheckText : UITextField = {
        let passwordCheck = UITextField()
        passwordCheck.placeholder = "비밀번호 확인"
        passwordCheck.layer.borderWidth = 1
        return passwordCheck
    }()
    
    let signButton : UIButton = {
        let button = UIButton()
        button.setTitle("가입하기", for: .normal)
        button.backgroundColor = UIColor().getCustomGreen()
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
        setupView()
        setUpConstraints()
        
        emailText.addTarget(self, action: #selector(emailTextFieldDidChange(_:)), for: .editingChanged)
        nicknameText.addTarget(self, action: #selector(nicknameTextFieldDidChange(_:)), for: .editingChanged)
        passwordText.addTarget(self, action: #selector(passwordTextFieldDidChange(_:)), for: .editingChanged)
        
        signButton.addTarget(self, action: #selector(signButtonClicked), for: .touchUpInside)
        
    }
    
    @objc func emailTextFieldDidChange(_ textfield: UITextField) {
        viewModel.email.value = textfield.text ?? ""
    }
    
    @objc func nicknameTextFieldDidChange(_ textfield: UITextField) {
        viewModel.username.value = textfield.text ?? ""
    }
    
    @objc func passwordTextFieldDidChange(_ textfield: UITextField) {
        viewModel.password.value = textfield.text ?? ""
    }
    
    func setupView() {
        
        self.view.backgroundColor = .white
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(closeButtonClicked))
    
        self.view.addSubview(stackView)
        
        [emailText,nicknameText,passwordText,passwordCheckText,signButton].forEach {
            self.stackView.addArrangedSubview($0)
        }
        
    }
    
    @objc func closeButtonClicked(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func setUpConstraints() {
        self.stackView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(40)
            make.centerX.equalToSuperview()
            make.width.equalTo(self.view.snp.width).multipliedBy(0.8)
            make.height.equalTo(200)
        }
    }

    @objc func signButtonClicked() {
        
        viewModel.fetchSignUpAPI {
            
            DispatchQueue.main.async {
                let svc = PostViewController()
                
                let nav = UINavigationController(rootViewController: svc)
                
                nav.modalPresentationStyle = .fullScreen

                self.present(nav, animated: true, completion: nil)
            }
            
        }
        
    }

    
    
}
