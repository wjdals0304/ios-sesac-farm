//
//  StartViewController.swift
//  SeSACLogin
//
//  Created by 김정민 on 2022/01/04.
//

import UIKit
import SnapKit

class StartViewController: UIViewController {
    
    let logImage : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo_ssac_clear.png")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let labelStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 2
        view.distribution = .fillEqually
        return view
    }()
    
    let titleLabel : UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "당신 근처의 새싹농장"
        titleLabel.textAlignment = .center
        return titleLabel
    }()
    
    let subTitleLabel : UILabel = {
        let subTitleLabel = UILabel()
        subTitleLabel.text = "iOS 지식부터 바람의 나라까지\n지금 SeSAC에서 함께해보세요!"
        subTitleLabel.numberOfLines = 0
        subTitleLabel.textAlignment = .center
        return subTitleLabel
    }()
    
    let stackViewButton: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 8
        view.distribution = .fillEqually
        return view
    }()
    
    let startButton : UIButton = {
        let button = UIButton()
        button.setTitle("시작하기", for: .normal)
        button.backgroundColor = .green
        button.addTarget(self, action: #selector(signUp), for: .touchUpInside)
        return button
    }()
    
    let stackViewLogin : UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 5
        view.distribution = .fillEqually
        return view
    }()
    
    let labelLogin : UILabel = {
        let label = UILabel()
        label.text = "이미 계정이 있나요?"
        label.textAlignment = .right
        return label
    }()
    
    let buttonLogin : UIButton = {
        let button = UIButton()
        button.setTitle("로그인", for: .normal)
        button.setTitleColor(.green, for: .normal)
        button.titleLabel?.textAlignment = .right
        button.addTarget(self, action: #selector(login), for: .touchUpInside)
        return button
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setUpConstraints()
    }
    
    @objc func login() {
        
        let svc = LoginViewController()
        
        let nav = UINavigationController(rootViewController: svc)
        
        nav.modalPresentationStyle = .fullScreen

        self.present(nav, animated: true, completion: nil)
        
    }
    
    @objc func signUp() {
        
        let svc = SignUpViewController()
        
        let nav = UINavigationController(rootViewController: svc)
        
        nav.modalPresentationStyle = .fullScreen

        self.present(nav, animated: true, completion: nil)

    }
    
    func setUpView() {
        
        self.view.backgroundColor = .white
        self.view.addSubview(logImage)
        self.view.addSubview(labelStackView)
        self.view.addSubview(stackViewButton)

        
        self.labelStackView.addArrangedSubview(titleLabel)
        self.labelStackView.addArrangedSubview(subTitleLabel)
        
        self.stackViewButton.addArrangedSubview(startButton)
        self.stackViewButton.addArrangedSubview(stackViewLogin)
        self.stackViewLogin.addArrangedSubview(labelLogin)
        self.stackViewLogin.addArrangedSubview(buttonLogin)
        
    }
    
    func setUpConstraints() {
        
        self.logImage.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(200)
        }
        
        self.labelStackView.snp.makeConstraints { make in
            make.top.equalTo(self.logImage.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
            make.width.equalTo(self.view.snp.width).multipliedBy(0.8)
            make.height.equalTo(100)
        }
    
      

        
//        self.titleLabel.snp.makeConstraints { make in
//
//         }
//
//        self.subTitleLabel.snp.makeConstraints { make in
//            make.top.equalTo(self.titleLabel.snp.bottom)
//            make.centerX.equalToSuperview()
//            make.width.equalTo(self.view.snp.width).multipliedBy(0.8)
//            make.height.equalTo(100)
//        }
//
        
        self.stackViewButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-40)
            make.centerX.equalToSuperview()
            make.width.equalTo(self.view.snp.width).multipliedBy(0.8)
            make.height.equalTo(100)
            }
        
     }
    
}
