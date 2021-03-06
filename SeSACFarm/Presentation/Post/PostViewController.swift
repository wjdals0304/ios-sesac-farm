//
//  PostViewController.swift
//  SeSACLogin
//
//  Created by 김정민 on 2022/01/04.
//

import UIKit

final class PostViewController: UIViewController {
    
    private let tableView = UITableView()
    
    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.contentMode = .scaleAspectFit
        button.tintColor  = UIColor.white
        button.backgroundColor = UIColor().getCustomGreen()
        button.layer.cornerRadius = 30
        button.addTarget(self, action: #selector(addPostClicked), for: .touchUpInside)
        // button image size
        button.setPreferredSymbolConfiguration(.init(pointSize: 40, weight: .regular, scale: .default), forImageIn: .normal)
        return button
    }()
    
    private var viewModel = PostViewModel()
    private var postArray: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.title = "새싹농장"
        
        setUpView()
        setUpViewConstraints()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PostCell.self, forCellReuseIdentifier: "PostCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        
        refreshTable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print(#function)
        refreshTable()
    }
    
    func setUpView() {
        view.addSubview(tableView)
        view.addSubview(addButton)
    }
    
    func setUpViewConstraints() {
      
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        addButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(40)
            make.bottom.equalToSuperview().inset(60)
            make.height.equalTo(60)
            make.width.equalTo(60)
        }
    }
    
    func refreshTable() {
        self.viewModel.getPost { [weak self] response in
            DispatchQueue.main.async {
                self?.postArray =  response
                self?.tableView.reloadData()
            }
        }
    }
    
    @objc func addPostClicked() {
        let pvc = PostUpdateViewController()
        navigationController?.pushViewController(pvc, animated: true)
    }
    
}

extension PostViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as? PostCell else { return .init() }
        
        let data = postArray[indexPath.row]
        
        cell.nickNameLabel.text = "\(data.user.username)"
        
        cell.titleTextLabel.text = "\(data.text)"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.timeZone = NSTimeZone(name: "ko_KR") as TimeZone?
        
        let createDate = dateFormatter.date(from: data.createdAt)!
        
        dateFormatter.dateFormat = "MM/dd"
        cell.createDateLabel.text = "\(dateFormatter.string(from: createDate))"
        
        let commentCount = data.comments.count
    
        cell.commentWriteLabel.text = commentCount == 0 ? "댓글쓰기" : "댓글 \(commentCount)"
        
        cell.layer.borderWidth = 5
        cell.layer.borderColor = UIColor().getCustomGray().cgColor

        return cell

    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
        let postData = postArray[indexPath.row]
        let pvc = PostDetailViewController(postData: postData)
        navigationController?.pushViewController(pvc, animated: true)
    }

}
class PostCell: UITableViewCell {
    
    let nickNameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor().getCustomGray()
        return label
    }()
    let titleTextLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.adjustsFontSizeToFitWidth = true
        label.sizeToFit()
        return label
    }()
    let createDateLabel = UILabel()
    let lineView = UIView()
    let commentWriteLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        [nickNameLabel, titleTextLabel, createDateLabel, lineView, commentWriteLabel].forEach {
            contentView.addSubview($0)
        }
        
        nickNameLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(20)
    
        }
        
        titleTextLabel.snp.makeConstraints { make in
            make.top.equalTo(nickNameLabel.snp.bottom).offset(20)
            make.leading.equalTo(nickNameLabel.snp.leading)
            make.trailing.equalToSuperview().inset(20)
            
        }
        
        createDateLabel.snp.makeConstraints { make in
            make.top.equalTo(titleTextLabel.snp.bottom).offset(20)
            make.leading.equalTo(titleTextLabel.snp.leading)
            
        }
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(createDateLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
            
        }
        
        lineView.backgroundColor = UIColor().getCustomGray()
        
        commentWriteLabel.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(10)
            make.leading.equalTo(titleTextLabel)
            make.bottom.equalToSuperview().inset(10)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder: has not been implemented")
    }
    
}
