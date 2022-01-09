//
//  PostDetailViewController.swift
//  SeSACLogin
//
//  Created by 김정민 on 2022/01/09.
//

import Foundation
import UIKit


class PostDetailViewController : UIViewController {
    
    private let postData : Post
    
    let scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = false
        return scrollView
    }()
    
    let stackView = UIStackView()
    
    let mainTextView = UIView()
    let imageView = UIImageView()
    let userNameLabel = UILabel()
    let createDateLabel = UILabel()
    let titleTextLabel = UILabel()
    
    let lineView : UIView = {
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
        scrollView.addSubview(stackView)
        
        _ = [mainTextView, commentTableView ].map { self.stackView.addSubview($0) }
        
     }
    
    func setUpConstraint() {
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.centerX.top.bottom.equalToSuperview()
        }
        
        mainTextView.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            make.height.equalTo(300)
        }
        
        commentTableView.snp.makeConstraints { make in
            make.top.equalTo(mainTextView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(300)
            make.bottom.equalToSuperview()
        }
        
    }
    
}


extension PostDetailViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        cell.textLabel?.text = "\(indexPath.item)"
        
        return cell
    }
}


class PostDetailCell: UITableViewCell {
    
    
}
