//
//  PostViewController.swift
//  SeSACLogin
//
//  Created by 김정민 on 2022/01/04.
//

import UIKit

class PostViewController: UIViewController {
    
    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("postviewcontroller")
        
        
        setUpView()
        setUpViewConstraints()

    }
    
    func setUpView() {
        view.addSubview(tableView)
        
        
    }
    
    func setUpViewConstraints() {
      
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
    

}
