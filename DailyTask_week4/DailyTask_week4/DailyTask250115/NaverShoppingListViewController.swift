//
//  NaverShoppingListViewController.swift
//  DailyTask_week4
//
//  Created by 박신영 on 1/15/25.
//

import UIKit

class NaverShoppingListViewController: BaseViewController {
    
    var searchText = "searchText"

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .brown
    }
    
    override func setHierarchy() {}
    
    override func setLayout() {}
    
    override func setStyle() {
        navigationController?.navigationBar.tintColor = .white
        
        navigationItem.title = searchText
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"),
                                                           style: .done,
                                                           target: self,
                                                           action: #selector(navLeftBtnTapped))
        
    }

}

private extension NaverShoppingListViewController {
    
    @objc
    func navLeftBtnTapped() {
        print(#function)
        navigationController?.popViewController(animated: true)
    }
    
}
