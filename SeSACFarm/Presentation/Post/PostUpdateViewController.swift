//
//  PostUpdateViewController.swift
//  SeSACLogin
//
//  Created by 김정민 on 2022/01/10.
//

import UIKit

final class PostUpdateViewController: UIViewController {
    
    private var postData: Post?
    private let viewModel = PostViewModel()

    private lazy var completeBarButton: UIBarButtonItem = {
        let barButtonItem =
        UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(didCompleteButtonClicked(_:)))
        return barButtonItem
    }()
    
    private lazy var backBarButton: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(closeButtonClicked))
        return barButtonItem
    }()
    
    private var textView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 20)
        return textView
    }()
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    init(postData: Post) {
        self.postData = postData
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setUpConstraint()
        if postData != nil {
            self.textView.text = postData?.text
        }
    }
    
    @objc func closeButtonClicked() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func didCompleteButtonClicked(_ sender: UIBarButtonItem) {
        NotificationCenter.default.post(name: NSNotification.Name("postData_text"), object: textView.text)

        if postData != nil {
            viewModel.updatePost(id: String(postData?.id ?? 0), text: textView.text) { _ in
                DispatchQueue.main.async { [weak self] in
                    self?.navigationController?.popViewController(animated: true)
                }
            }
        
        } else {
             viewModel.savePost(text: textView.text) { _ in
                DispatchQueue.main.async { [weak self] in
                   self?.navigationController?.popViewController(animated: true)
             }
        }
            
       }
    }
    
    func setup() {
        navigationItem.title = "새싹농장 글쓰기"
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = completeBarButton
        navigationItem.leftBarButtonItem = backBarButton
        navigationItem.rightBarButtonItem?.tintColor = .black
        navigationItem.leftBarButtonItem?.tintColor = .black
        self.view.addSubview(textView)
    }
    
    func setUpConstraint() {
        
        textView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.bottom.top.equalToSuperview()
        }
    }
}
