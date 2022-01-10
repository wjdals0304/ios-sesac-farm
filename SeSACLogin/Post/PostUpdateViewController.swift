//
//  PostUpdateViewController.swift
//  SeSACLogin
//
//  Created by 김정민 on 2022/01/10.
//

import Foundation
import UIKit


class PostUpdateViewController : UIViewController {
    
    lazy var completeBarButton: UIBarButtonItem = {
        let barButtonItem =
        UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(didCompleteButtonClicked(_:)))
        return barButtonItem
    }()
    
    var backBarButton : UIBarButtonItem = {
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
        //dismiss 제대로 동작 x
//        self.dismiss(animated: true, completion: nil)
        let vc = PostViewController()
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc func didCompleteButtonClicked(_ sender: UIBarButtonItem) {
        
        

    }
 
    func setup(){
        navigationItem.rightBarButtonItem = completeBarButton
        navigationItem.leftBarButtonItem = backBarButton
        
        self.view.addSubview(textView)
    }
    
    func setUpConstraint() {
        
        textView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
            
        }
        
        
    }
}
