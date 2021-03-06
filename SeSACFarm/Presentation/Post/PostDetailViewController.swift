//
//  PostDetailViewController.swift
//  SeSACLogin
//
//  Created by 김정민 on 2022/01/09.
//

import Foundation
import UIKit
import SnapKit
import Toast

final class PostDetailViewController: UIViewController {
    
    private var postData: Post
    private var commentArray: [CommentElement] = []
    private var postViewModel = PostViewModel()
    private var commentViewModel = CommentViewModel()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = false
        scrollView.isScrollEnabled = true
        return scrollView
    }()
    
    private lazy var updateBarButton: UIBarButtonItem = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal )
        button.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
        button.addTarget(self, action: #selector(ellipsisClicked), for: .touchUpInside)
        button.tintColor = .black
        let barButtonItem = UIBarButtonItem(customView: button)
        barButtonItem.style = .plain
        barButtonItem.target = self
        return barButtonItem
    }()
    
    private let contentView = UIView()
    private let mainTextView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor().getCustomGray().cgColor
        return view
    }()

    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    private let createDateLabel = UILabel()
    private let titleTextLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.adjustsFontSizeToFitWidth = true
        label.sizeToFit()
        return label
    }()

    private let titleTextView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor().getCustomGray().cgColor
        return view
    }()
    
    private let commentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.adjustsFontSizeToFitWidth = true
        label.sizeToFit()
        return label
    }()
    
    private let textView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor().getCustomGray().cgColor
        return view
    }()
    
    private let commentTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor().getCustomGray()
        textField.placeholder = "댓글을 입력해주세요."
        textField.layer.cornerRadius = 10
        return textField
    }()
    
    private lazy var addCommentButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor  = UIColor.white
        button.backgroundColor = UIColor().getCustomGreen()
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(addCommentClicked), for: .touchUpInside)
        return button
    }()
    
    private lazy var commentTableView: UITableView = {
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
        
        // MARK: 키보드 디텍션
        NotificationCenter.default.addObserver(self, selector: #selector(adjustInputView), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(adjustInputView), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapBG))
        view.addGestureRecognizer(tap)
        
        commentTableView.rowHeight = UITableView.automaticDimension
        commentTableView.estimatedRowHeight = 200
        
    }
    
    @objc func tapBG(_ sender: Any) {
       self.view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(reload_text(_:)), name: NSNotification.Name("postData_text"), object: nil)
        setUpData()
    }
    
    init(postData: Post) {
        self.postData = postData
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func reload_text(_ notification: Notification) {
        guard let object = notification.object as? String else {
            return
        }
        self.postData.text = object
        
    }
    
    func setUpData() {
        
        self.commentViewModel.getComment(id: String(postData.id)) { [weak self] response in
            DispatchQueue.main.async {
                
                self?.commentArray = response
                self?.commentTableView.reloadData()
                self?.commentLabel.text = response.count == 0 ? "댓글쓰기" : "댓글 \(response.count)"
                // MARK: 댓글 테이블뷰 사이즈 조절
                if response.count == 0 {
                    
                    self?.resetTableViewContraints()
                    self?.commentTableView.snp.makeConstraints { make in
                        make.height.equalTo(UIScreen.main.bounds.size.height - 300 )
                    }
                    
                } else {
                    
                    self?.resetTableViewContraints()
                    
                    let tableViewHeight: Int = Int(UIScreen.main.bounds.size.height - 300)
                    var resultHeight = 0
                    
                    if tableViewHeight >= Int(100 * response.count + 50) {
                            resultHeight = tableViewHeight
                    } else {
                        resultHeight = response.count * 200 + 50
                    }

                    self?.commentTableView.snp.makeConstraints { make in
                        make.height.equalTo(resultHeight)
                    }
                }
            }
        }
        
        self.commentTableView.register(PostDetailCell.self, forCellReuseIdentifier: "PostDetailCell")
        self.userNameLabel.text = "\(postData.user.username)"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.timeZone = NSTimeZone(name: "ko_KR") as TimeZone?
        
        let createDate = dateFormatter.date(from: postData.createdAt)!
        
        dateFormatter.dateFormat = "MM/dd"
        self.createDateLabel.text = "\(dateFormatter.string(from: createDate))"
        self.titleTextLabel.text = "\(postData.text)"

    }
    
    func setUp() {
        
        navigationController?.navigationBar.prefersLargeTitles = false

        self.view.backgroundColor = .systemBackground
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        self.contentView.addSubview(mainTextView)
        self.contentView.addSubview(commentTableView)
        
        [userNameLabel, createDateLabel, titleTextView, commentLabel, commentTextField].forEach {
            self.mainTextView.addSubview($0)
        }
        self.titleTextView.addSubview(titleTextLabel)
        self.contentView.addSubview(textView)
        self.textView.addSubview(commentTextField)
        self.textView.addSubview(addCommentButton)
        
        navigationItem.rightBarButtonItem = updateBarButton
        let backBarButton = UIBarButtonItem(image: UIImage(systemName: "arrow.backward"), style: .plain, target: self, action: #selector(closeButtonClicked))
        navigationItem.leftBarButtonItem = backBarButton
        navigationItem.leftBarButtonItem?.tintColor = .black
        navigationItem.rightBarButtonItem?.tintColor = .black

        navigationController?.navigationBar.barTintColor = .systemBackground
     }
    
    func setUpConstraint() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(self.view)
        }
        contentView.snp.makeConstraints { make in
            make.width.equalTo(self.scrollView.snp.width)
            make.height.greaterThanOrEqualTo(view.snp.height).priority(.low)
            make.edges.equalTo(scrollView.contentLayoutGuide)
        }
        
        mainTextView.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
        }
        
        userNameLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(20)
        }
        
        createDateLabel.snp.makeConstraints { make in
            make.top.equalTo(userNameLabel).offset(20)
            make.leading.equalToSuperview().offset(20)
        }
        
        titleTextView.snp.makeConstraints { make in
            make.top.equalTo(createDateLabel).offset(30)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(commentLabel).inset(30)
            make.height.greaterThanOrEqualTo(100)
        }
        
        titleTextLabel.snp.makeConstraints { make in

            make.leading.equalTo(titleTextView).offset(20)
            make.trailing.equalTo(titleTextView).inset(20)
            make.top.bottom.equalTo(titleTextView)
        }
        
        commentLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().inset(20)
            
        }

        commentTableView.snp.makeConstraints { make in
            make.top.equalTo(mainTextView.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        textView.snp.makeConstraints { make in
            make.bottom.equalTo(scrollView.frameLayoutGuide)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(5)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(5)
            make.height.equalTo(100)
        }
        
        commentTextField.snp.makeConstraints { make in
            make.top.equalTo(textView.safeAreaLayoutGuide).offset(5)
            make.leading.equalTo(textView.safeAreaLayoutGuide).offset(5)
            make.trailing.equalTo(textView.safeAreaLayoutGuide).inset(5)
            make.height.equalTo(textView).multipliedBy(0.7)
        }
        
        addCommentButton.snp.makeConstraints { make in
            make.trailing.equalTo(commentTextField.snp.trailing).inset(5)
            make.bottom.equalTo(commentTextField.snp.bottom).inset(5)
            make.height.equalTo(commentTextField).multipliedBy(0.8)
            make.width.equalTo(commentTextField).multipliedBy(0.1)
        }
        
    }
    
    @objc func addCommentClicked() {
        
        commentViewModel.saveComment(id: String(postData.id), comment: commentTextField.text! ) { comment in
            DispatchQueue.main.async { [weak self] in
                self?.setUpData()
                self?.commentTableView.reloadData()
                self?.commentTextField.text = ""
            }
        }
    }
    
    @objc func ellipsisClicked(_ sender: UIBarButtonItem) {
        let userId = UserDefaults.standard.integer(forKey: "id")
        
        // MARK: 사용권한
        if userId != self.postData.user.id {
            self.view.makeToast("본인이 작성한 글만 수정할 수 있습니다.", duration: 1.0, position: .bottom)
            return
        }
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let update = UIAlertAction(title: "수정", style: .default) { UIAlertAction in
            let pvc = PostUpdateViewController(postData: self.postData)
            self.navigationController?.pushViewController(pvc, animated: true)
        }
        
        let cancel = UIAlertAction(title: "닫기", style: .cancel, handler: nil)
        let destructive = UIAlertAction(title: "삭제", style: .destructive) { _ in
            
            self.postViewModel.deletePost(id: String(self.postData.id)) { _ in
                    DispatchQueue.main.async { [weak self] in
                        self?.navigationController?.popViewController(animated: true)
                    }
            }
        }

        alert.addAction(update)
        alert.addAction(cancel)
        alert.addAction(destructive)

       self.present(alert, animated: true, completion: nil)
    }
    
    func resetTableViewContraints() {
        commentTableView.snp.removeConstraints()
        commentTableView.snp.makeConstraints { make in
            make.top.equalTo(mainTextView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    @objc func closeButtonClicked() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension PostDetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostDetailCell") as? PostDetailCell else { return .init() }
        
        let data = commentArray[indexPath.row]
        
        cell.nickNameLabel.text = "\(data.user.username)"
        cell.commentTextLabel.text = "\(data.comment)"
        
        cell.showAlertAction = { [ unowned self] in
            self.showAlert(data: self.commentArray[indexPath.row])
        }
        
        return cell
    }
    
    func showAlert(data: CommentElement) {
        
        let userId = UserDefaults.standard.integer(forKey: "id")
        
        // MARK: 사용권한
        if userId != data.user.id  {
            self.view.makeToast("본인이 작성한 글만 수정할 수 있습니다.", duration: 1.0, position: .bottom)
            return
        }
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let update = UIAlertAction(title: "수정", style: .default) { UIAlertAction in
            let vc = CommentUpdateViewController(commentData: data)
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        let cancel = UIAlertAction(title: "닫기", style: .cancel, handler: nil)
        
        let destructive = UIAlertAction(title: "삭제", style: .destructive) { _ in
            
                self.commentViewModel.deleteComment(commentId: String(data.id)) { _ in
                    DispatchQueue.main.async { [weak self] in
                        self?.setUpData()
                        self?.commentTableView.reloadData()
                    }
                }
        }

        alert.addAction(update)
        alert.addAction(cancel)
        alert.addAction(destructive)

       self.present(alert, animated: true, completion: nil)
    }

}

class PostDetailCell: UITableViewCell {
    
    let nickNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    let commentTextLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    lazy var updateButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal )
        button.tintColor = .gray
        button.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
        return button
    }()
    
    var showAlertAction : (() -> ())?
    
    override init(style: UITableViewCell.CellStyle ,reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        [nickNameLabel, commentTextLabel, updateButton].forEach {
            contentView.addSubview($0)
        }
        
        nickNameLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(20)
            
        }
        
        commentTextLabel.snp.makeConstraints { make in
            make.top.equalTo(nickNameLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(20)
        }
        updateButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.top.equalToSuperview().offset(20)
        }
        
        self.updateButton.addTarget(self, action: #selector(showAlertClicked), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: has not been implemented")
    }
    
    @objc func showAlertClicked() {
        showAlertAction?()
    }
    
}

extension PostDetailViewController {
    
    @objc private func adjustInputView(noti: Notification) {
        guard let userInfo = noti.userInfo else { return }

        guard let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        
        if noti.name == UIResponder.keyboardWillShowNotification {
            let adjustmentHeight = keyboardFrame.height - view.safeAreaInsets.bottom

            textView.snp.updateConstraints { make in
                make.bottom.equalTo(scrollView.frameLayoutGuide).inset(adjustmentHeight)
            }
            
        } else {
            textView.snp.updateConstraints { make in
                make.bottom.equalTo(scrollView.frameLayoutGuide)
            }
        }
    }
}
