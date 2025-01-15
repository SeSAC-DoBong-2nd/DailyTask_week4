//
//  NaverSearchViewController.swift
//  DailyTask_week4
//
//  Created by 박신영 on 1/15/25.
//

import UIKit

import SnapKit
import Then

class NaverSearchViewController: BaseViewController {
    
    let searchBar = UISearchBar()
    let emptyView = UIView()
    let imageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()

        setRegister()
    }
    
    override func setHierarchy() {
        view.addSubviews(searchBar, imageView)
        
//        emptyView.addSubview()
    }
    
    override func setLayout() {
        searchBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(40)
        }
        
        imageView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(170)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(320)
            $0.height.equalTo(300)
        }
    }
    
    override func setStyle() {
        view.backgroundColor = .black
        
        navigationItem.title = "psy의 쇼핑쇼핑"
        
        searchBar.do {
            $0.placeholder = "브랜드, 상품, 프로필, 태그 등"
        }
        
        imageView.do {
            $0.image = UIImage(resource: .emptyView)
        }
    }

}

private extension NaverSearchViewController {
    
    func setRegister() {
        searchBar.delegate = self
    }
    
}

extension NaverSearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(#function, searchBar.text ?? "")
        view.endEditing(true)
    }
    
}
