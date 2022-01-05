//
//  PostViewController.swift
//  SeSACLogin
//
//  Created by 김정민 on 2022/01/04.
//

import UIKit

class PostViewController: UIViewController {
    
    let tableView = UITableView()
    
    private var viewModel = PostViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PostCell.self, forCellReuseIdentifier: "PostID")
        
        view.backgroundColor = .white
        setUpView()
        setUpViewConstraints()
        
        self.viewModel.getPost()
        
        print(self.viewModel.post.value)
        
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


extension PostViewController : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5 
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostID") else {
            return .init()
        }
        
        
        return cell
        
    }
    
    
    
    
}


class PostCell : UITableViewCell {
    
    let nickNameLabel = UILabel()
    let titleTextLabel = UILabel()
    let createDateLabel = UILabel()
    let lineView = UIView()
    let commentWriteButton = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        [nickNameLabel,titleTextLabel,createDateLabel,lineView,commentWriteButton].forEach {
            contentView.addSubview($0)
        }
        
        nickNameLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(self.contentView.safeAreaLayoutGuide).offset(20)
            
        }
        
        
        
        
    }
    
    required init?(coder: NSCoder){
        fatalError("init(coder: has not been implemented")
    }
    
    
}
