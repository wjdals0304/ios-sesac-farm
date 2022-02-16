//
//  SignUpViewController.swift
//  SeSACLogin
//
//  Created by 김정민 on 2022/01/04.
//

import UIKit

class SignUpViewController: UIViewController {

    let viewModel = SignUpViewModel()
    
    let emailText : UITextField = {
        let email = UITextField()
        email.placeholder = "이메일 주소"
        email.layer.borderWidth = 2
        email.layer.cornerRadius = 8
        email.layer.borderColor = UIColor().getCustomGray().cgColor
        email.clipsToBounds = true
        return email
    }()
    
    let nicknameText : UITextField = {
        let nickname = UITextField()
        nickname.placeholder = "닉네임"
        nickname.layer.borderWidth = 2
        nickname.layer.borderColor = UIColor().getCustomGray().cgColor
        nickname.layer.cornerRadius = 8
        return nickname
    }()
    
    let passwordText : UITextField = {
        let password = UITextField()
        password.placeholder = "비밀번호"
        password.layer.borderWidth = 2
        password.layer.borderColor = UIColor().getCustomGray().cgColor
        password.isSecureTextEntry = true
        password.layer.cornerRadius = 8
        return password
    }()
    
    let passwordCheckText : UITextField = {
        let passwordCheck = UITextField()
        passwordCheck.placeholder = "비밀번호 확인"
        passwordCheck.layer.borderWidth = 2
        passwordCheck.layer.borderColor = UIColor().getCustomGray().cgColor
        passwordCheck.layer.cornerRadius = 8
        passwordCheck.isSecureTextEntry = true
        return passwordCheck
    }()
    
    let signButton : UIButton = {
        let button = UIButton()
        button.setTitle("가입하기", for: .normal)
        button.backgroundColor = UIColor().getCustomGreen()
        button.layer.cornerRadius = 8
        return button
    }()
    
    let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 5
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
        navigationItem.leftBarButtonItem?.tintColor = .black
        navigationItem.title = "새싹농장 가입하기"
        
        
        
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
            make.height.equalTo(250)
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
