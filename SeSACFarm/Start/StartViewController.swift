//
//  StartViewController.swift
//  SeSACLogin
//
//  Created by 김정민 on 2022/01/04.
//

import UIKit
import SnapKit

final class StartViewController: UIViewController {
    
    private let logImage : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo_ssac_clear.png")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let labelStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 0
        view.distribution = .fillEqually
        return view
    }()
    
   private let titleLabel : UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "당신 근처의 새싹농장"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 22)
        return titleLabel
    }()
    
   private  let subTitleLabel : UILabel = {
        let subTitleLabel = UILabel()
        subTitleLabel.text = "iOS 지식부터 바람의 나라까지\n지금 SeSAC에서 함께해보세요!"
        subTitleLabel.numberOfLines = 0
        subTitleLabel.textAlignment = .center
        return subTitleLabel
    }()
    

    
   private let startButton : UIButton = {
        let button = UIButton()
        button.setTitle("시작하기", for: .normal)
        button.backgroundColor = UIColor().getCustomGreen()
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(signUp), for: .touchUpInside)
        return button
    }()
 
   private let labelLogin : UILabel = {
        let label = UILabel()
        label.text = "이미 계정이 있나요?"
        label.textAlignment = .right
        return label
    }()
    
   private let buttonLogin : UIButton = {
        let button = UIButton()
        button.setTitle("로그인", for: .normal)
        button.setTitleColor(UIColor().getCustomGreen(), for: .normal)
        button.titleLabel?.textAlignment = .center
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
        
        
        [
         logImage,
         labelStackView,
         startButton,
         labelLogin,
         buttonLogin
        ].forEach{ view.addSubview($0) }

        self.labelStackView.addArrangedSubview(titleLabel)
        self.labelStackView.addArrangedSubview(subTitleLabel)
        
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
        
        startButton.snp.makeConstraints { make in
            make.top.equalTo(labelStackView.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
            make.width.equalTo(self.view.snp.width).multipliedBy(0.8)
            make.height.equalTo(45)
        }
        
        labelLogin.snp.makeConstraints { make in
            make.top.equalTo(startButton.snp.bottom).offset(10)
            make.leading.equalTo(startButton.snp.leading).offset(45)
        }
        
        buttonLogin.snp.makeConstraints { make in
            make.leading.equalTo(labelLogin.snp.trailing).offset(10)
            make.centerY.equalTo(labelLogin)
            make.width.equalTo(50)
            make.height.equalTo(50)
        }

        
     }
    
}
