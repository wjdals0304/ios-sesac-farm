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
        
        view.backgroundColor = .white
        setUpView()
        setUpViewConstraints()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PostCell.self, forCellReuseIdentifier: "PostCell")
        
        viewModel.post.bind { datas in
            self.tableView.reloadData()
        }
        
        self.viewModel.getPost()
    
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
        print(viewModel.post.value.count)
        return viewModel.post.value.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as? PostCell else { return .init() }
        
        let data = viewModel.cellForRowAt(at: indexPath)
        cell.nickNameLabel.text = "\(data.user.username)"
        
        return cell

        }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
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
