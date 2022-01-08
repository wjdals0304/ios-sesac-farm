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
    private var postArray : [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setUpView()
        setUpViewConstraints()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PostCell.self, forCellReuseIdentifier: "PostCell")
        
        self.viewModel.getPost { [weak self] response in
            DispatchQueue.main.async {
                self?.postArray =  response
                self?.tableView.reloadData()
            }
            
        }
    }
    
    func setUpView() {
        view.addSubview(tableView)
    }
    
    func setUpViewConstraints() {
      
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            
        }
    }
    
}


extension PostViewController : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as? PostCell else { return .init() }
        
        let data = postArray[indexPath.row]
        
        cell.nickNameLabel.text = "\(data.user.username)"
        
        cell.titleTextLabel.text = "\(data.text)"
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssXXXXX"
        
//        var createDateString = ""
        
        if let date = dateFormatter.date(from: data.createdAt) {
            dateFormatter.dateFormat = "MM/dd"
            let createDateString = dateFormatter.string(from: date)
            print(createDateString)
        }
//        print(data.createdAt)
        let convertDate = dateFormatter.date(from: "")
        
        cell.createDateLabel.text = "\(String(describing: convertDate))"
        
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
        
        titleTextLabel.snp.makeConstraints { make in
            make.top.equalTo(nickNameLabel.snp.bottom).offset(20)
            make.leading.equalTo(nickNameLabel)
        }
        
        createDateLabel.snp.makeConstraints { make in
            make.top.equalTo(titleTextLabel.snp.bottom).offset(20)
            make.leading.equalTo(titleTextLabel)
            
        }
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(createDateLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
        }
        commentWriteButton.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(20)
            make.leading.equalTo(titleTextLabel)
        }
        
    
    }
    
    required init?(coder: NSCoder){
        fatalError("init(coder: has not been implemented")
    }
    
    
}
