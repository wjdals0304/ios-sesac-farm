//
//  PostDetailViewController.swift
//  SeSACLogin
//
//  Created by 김정민 on 2022/01/09.
//

import Foundation
import UIKit
import SnapKit

class PostDetailViewController : UIViewController {
    
    private let postData : Post
    
    let scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = false
        scrollView.isScrollEnabled = true
        return scrollView
    }()
    
    let contentView = UIView()
    let mainTextView = UIView()

    let userNameLabel = UILabel()
    let createDateLabel = UILabel()
    let titleTextLabel = UILabel()
    
    let lineView1 : UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    
    let lineView2 : UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    
    let commentLabel = UILabel()
    
    lazy private var commentTableView : UITableView = {
       let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.bounces = true
        tableView.isScrollEnabled = false
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        setUp()
        setUpConstraint()
        
        self.commentTableView.register(PostDetailCell.self, forCellReuseIdentifier: "PostDetailCell")
        
        
        self.userNameLabel.text = "\(postData.user.username)"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.timeZone = NSTimeZone(name: "ko_KR") as TimeZone?
        
        let createDate = dateFormatter.date(from: postData.createdAt)!
        
        dateFormatter.dateFormat = "MM/dd"
        self.createDateLabel.text = "\(dateFormatter.string(from: createDate))"
        self.titleTextLabel.text = "\(postData.text)"


        let commentCount = postData.comments.count
        self.commentLabel.text = commentCount == 0 ? "댓글쓰기" : "댓글 \(commentCount)"
        
    }
    
    init(postData: Post) {
        self.postData = postData
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setUp() {
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
//        _ = [mainTextView, commentTableView ].map { self.contentView.addSubview($0) }
//
        self.contentView.addSubview(mainTextView)
        self.contentView.addSubview(commentTableView)
        
        [userNameLabel,createDateLabel, titleTextLabel,lineView1,lineView2,commentLabel ].forEach {
            self.mainTextView.addSubview($0)
        }
        
     }
    
    func setUpConstraint() {
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.centerX.top.bottom.equalToSuperview()
        }
        
        mainTextView.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            make.height.equalTo(300)
        }
        
        userNameLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(20)
        }
        
        createDateLabel.snp.makeConstraints { make in
            make.top.equalTo(userNameLabel).offset(20)
            make.leading.equalToSuperview().offset(20)
        }
        
        lineView1.snp.makeConstraints { make in
            make.top.equalTo(createDateLabel).offset(20)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(2)
        }
        
        titleTextLabel.snp.makeConstraints { make in
            make.top.equalTo(lineView1).offset(20)
            make.leading.equalToSuperview().offset(20)
        }
        
        lineView2.snp.makeConstraints { make in
            make.top.equalTo(titleTextLabel).offset(50)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(2)

        }
        
        commentLabel.snp.makeConstraints { make in
            make.top.equalTo(lineView2).offset(10)
            make.leading.equalToSuperview().offset(20)
        }
        
        
        commentTableView.snp.makeConstraints { make in
            make.top.equalTo(mainTextView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(2000)

            make.bottom.equalToSuperview()
        }
            
        
    }
    
}


extension PostDetailViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostDetailCell") as? PostDetailCell else { return .init() }
        
        let data = postData.comments[indexPath.row]
        
        cell.nickNameLabel.text = "ddd"
        cell.commentTextLabel.text = "\(data.comment)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100 
    }

    
}


class PostDetailCell: UITableViewCell {
    
    let nickNameLabel = UILabel()
    let commentTextLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle ,reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        [nickNameLabel,commentTextLabel].forEach {
            contentView.addSubview($0)
        }
        
        nickNameLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(20)
            
        }
        commentTextLabel.snp.makeConstraints { make in
            make.top.equalTo(nickNameLabel).offset(10)
            make.leading.equalToSuperview().offset(20)
        }
        
    }
    
    required init?(coder: NSCoder){
        fatalError("init(coder: has not been implemented")
    }
    
}
