//
//  PostViewController.swift
//  SeSACLogin
//
//  Created by 김정민 on 2022/01/04.
//

import UIKit

class PostViewController: UIViewController {
    
    let tableView = UITableView()
    
    let addButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.contentMode = .scaleToFill
        button.tintColor  = UIColor.white
        button.backgroundColor = UIColor().getCustomGreen()
        button.layer.cornerRadius = 30
        button.addTarget(self, action: #selector(addPostClicked), for: .touchUpInside)
        return button
    }()
    
    private var viewModel = PostViewModel()
    private var postArray : [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.title = "새싹농장"
        navigationController?.navigationBar.prefersLargeTitles = true

        setUpView()
        setUpViewConstraints()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PostCell.self, forCellReuseIdentifier: "PostCell")
        
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
            make.trailing.equalToSuperview().inset(60)
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
        
        let vc = PostUpdateViewController()
        navigationController?.pushViewController(vc, animated: true)
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
        let postData = postArray[indexPath.row]
        let vc = PostDetailViewController(postData: postData)
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
   
    
}


class PostCell : UITableViewCell {
    
    let nickNameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor().getCustomGray()
        return label
    }()
    let titleTextLabel = UILabel()
    let createDateLabel = UILabel()
    let lineView = UIView()
    let commentWriteLabel = UILabel()


    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        [nickNameLabel,titleTextLabel,createDateLabel,lineView,commentWriteLabel].forEach {
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
            make.height.equalTo(1)
            
        }
        
        lineView.backgroundColor = UIColor().getCustomGray()
        commentWriteLabel.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(10)
            make.leading.equalTo(titleTextLabel)
        }
    
        
        
    }
    
    required init?(coder: NSCoder){
        fatalError("init(coder: has not been implemented")
    }
    
    
}
