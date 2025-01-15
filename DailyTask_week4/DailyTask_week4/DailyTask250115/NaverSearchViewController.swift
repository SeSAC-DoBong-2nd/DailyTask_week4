//
//  NaverSearchViewController.swift
//  DailyTask_week4
//
//  Created by 박신영 on 1/15/25.
//

import UIKit

import SnapKit
import Then

final class NaverSearchViewController: BaseViewController {
    
    private let searchBar = UISearchBar()
    private let emptyView = UIView()
    private let imageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()

        setRegister()
    }
    
    override func setHierarchy() {
        view.addSubviews(searchBar, imageView)
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
    
    func isValidSearchText(text: String) {
        switch text.count < 2 {
        case true:
            let alert = UIAlertUtil.showAlert(title: "조회 실패", message: "2글자 이상 입력해주세요.")
            present(alert, animated: true)
        case false:
            let vc = NaverShoppingListViewController()
            vc.searchText = text
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

extension NaverSearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(#function, searchBar.text ?? "")
        guard let text = searchBar.text else {
            print("searchBarSearchButtonClicked error")
            return
        }
        isValidSearchText(text: text)
        view.endEditing(true)
    }
    
}
