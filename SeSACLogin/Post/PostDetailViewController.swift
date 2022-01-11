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
    private var commentArray : [CommentElement] = []
    private var postViewModel = PostViewModel()
    private var commentViewModel = CommentViewModel()
    
    let scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = false
        scrollView.isScrollEnabled = true
        return scrollView
    }()
    
    let contentView = UIView()
    let mainTextView : UIView  = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.gray.cgColor
        return view
    }()

    let userNameLabel = UILabel()
    let createDateLabel = UILabel()
    let titleTextLabel = UILabel()
    
    let lineView1 : UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.gray.cgColor
        return view
    }()
    
    
    let lineView2 : UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.gray.cgColor
        return view
    }()
    
    let commentLabel = UILabel()
    
    let textView : UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.borderWidth = 1
        return view
    }()
    
    let commentTextField : UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .lightGray
        textField.placeholder = "댓글을 입력해주세요."
        textField.layer.cornerRadius = 10
        return textField
    }()
    
    let addCommentButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor  = UIColor.white
        button.backgroundColor = .green
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(addCommentClicked), for: .touchUpInside)
        return button
    }()
    
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
        setUpData()
        
        self.commentViewModel.getComment(id: String(postData.id)) {
            [weak self] response in
            DispatchQueue.main.async {
                self?.commentArray = response
                self?.commentTableView.reloadData()
            }
        }
            
    }
    
    init(postData: Post) {
        self.postData = postData
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setUpData() {
        
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
    
    
    func setUp() {
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
//        _ = [mainTextView, commentTableView ].map { self.contentView.addSubview($0) }
//
        self.contentView.addSubview(mainTextView)
        self.contentView.addSubview(commentTableView)
        
        [userNameLabel,createDateLabel, titleTextLabel,lineView1,lineView2,commentLabel ,commentTextField].forEach {
            self.mainTextView.addSubview($0)
        }
        
        self.contentView.addSubview(textView)
        self.textView.addSubview(commentTextField)
        self.textView.addSubview(addCommentButton)
        
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
        
        textView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(60)
        }
        
        commentTextField.snp.makeConstraints { make in
            make.leading.equalTo(textView.safeAreaLayoutGuide).offset(20)
            make.trailing.equalTo(textView.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(textView).multipliedBy(0.8)
        }
        
        addCommentButton.snp.makeConstraints { make in
            make.trailing.equalTo(commentTextField.snp.trailing).inset(5)
            make.height.equalTo(commentTextField).multipliedBy(0.8)
            make.width.equalTo(commentTextField).multipliedBy(0.1)
        }
        
    }
    
    @objc func addCommentClicked() {
        
        commentViewModel.saveComment(id: String(postData.id), comment: commentTextField.text! ) { comment in
            DispatchQueue.main.async { [weak self] in
                self?.commentTableView.reloadData()
            }
        }
    }
    
}


extension PostDetailViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostDetailCell") as? PostDetailCell else { return .init() }
        
        let data = commentArray[indexPath.row]
        
        cell.nickNameLabel.text = "\(data.user.username)"
        cell.commentTextLabel.text = "\(data.comment)"
        
        cell.showAlertAction = { [ unowned self] in
            self.showAlert()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100 
    }
    
    
    func showAlert() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let update = UIAlertAction(title: "수정", style: .default) { UIAlertAction in
            print("수정")
        }
        let cancel = UIAlertAction(title: "닫기", style: .cancel, handler: nil)
        let destructive = UIAlertAction(title: "삭제", style: .destructive, handler: nil)

        alert.addAction(update)
        alert.addAction(cancel)
        alert.addAction(destructive)

       self.present(alert, animated: true, completion: nil)
    }
    
    
    
}


class PostDetailCell: UITableViewCell {
    
    let nickNameLabel = UILabel()
    let commentTextLabel = UILabel()
    let updateButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "ellipsis"),for: .normal )
        button.tintColor = .gray
        button.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
        return button
    }()
    
    var showAlertAction : (() -> ())?
    
    override init(style: UITableViewCell.CellStyle ,reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        [nickNameLabel,commentTextLabel,updateButton].forEach {
            contentView.addSubview($0)
        }
        
        nickNameLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(20)
            
        }
        commentTextLabel.snp.makeConstraints { make in
            make.top.equalTo(nickNameLabel).offset(20)
            make.leading.equalToSuperview().offset(20)
        }
        updateButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.top.equalToSuperview().offset(20)
        }
        self.updateButton.addTarget(self, action: #selector(showAlertClicked), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder){
        fatalError("init(coder: has not been implemented")
    }
    
    @objc func showAlertClicked(){
        showAlertAction?()
    }
    
}
