//
//  CommentUpdateViewController.swift
//  SeSACLogin
//
//  Created by 김정민 on 2022/01/11.
//

import Foundation
import UIKit

class CommentUpdateViewController : UIViewController {
    
    private var commentData : CommentElement
    let commentViewModel = CommentViewModel()
    
    lazy var completeBarButton: UIBarButtonItem = {
        let barButtonItem =
        UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(didCompleteButtonClicked(_:)))
        return barButtonItem
    }()
    
    lazy var backBarButton : UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(closeButtonClicked))
        return barButtonItem
    }()
    
    var textView = UITextView()
    
    init(commentData: CommentElement) {
        self.commentData = commentData
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        setUp()
        sepUpConstraints()
    }
    
    func setUp(){
        navigationItem.title = "수정"
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = completeBarButton
        navigationItem.leftBarButtonItem = backBarButton
        
        self.view.addSubview(textView)
        self.textView.text = commentData.comment
    }
    
    func sepUpConstraints(){
        textView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().inset(30)
            make.height.equalTo(100)
        }
    }
    
    @objc func closeButtonClicked(){
        
        self.navigationController?.popViewController(animated: true)
   
    }
    
    @objc func didCompleteButtonClicked(_ sender: UIBarButtonItem) {
          
        commentViewModel.updateComment(commentId: String(commentData.id)
                                       , postId: String(commentData.post.id)
                                       , comment: textView.text) { response in
             DispatchQueue.main.async { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }
        }
        
        
    }
 
    
    
}
