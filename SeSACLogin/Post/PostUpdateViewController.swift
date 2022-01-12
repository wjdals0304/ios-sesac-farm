//
//  PostUpdateViewController.swift
//  SeSACLogin
//
//  Created by 김정민 on 2022/01/10.
//

import Foundation
import UIKit


class PostUpdateViewController : UIViewController {
    
    let viewModel = PostViewModel()
    
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
  
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        setup()
        setUpConstraint()
    }
    
    
    @objc func closeButtonClicked(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func didCompleteButtonClicked(_ sender: UIBarButtonItem) {
        
        viewModel.savePost(text: textView.text) { response in
            
            DispatchQueue.main.async { [weak self] in
               self?.navigationController?.popViewController(animated: true)
           }
            
        }
        
    }
 
    func setup(){
           
        navigationItem.title = "새싹농장 글쓰기"
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = completeBarButton
        navigationItem.leftBarButtonItem = backBarButton
        
        self.view.addSubview(textView)
    }
    
    func setUpConstraint() {
        
        textView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            
        }
        
        
    }
}
