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
    
    private let searchView = NaverSearchView()
    
    override func loadView() {
        self.view = searchView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setRegister()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        searchView.imageView.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        searchView.imageView.isHidden = true
    }
    
    override func setStyle() {
        view.backgroundColor = .black
        
        navigationItem.title = "psy의 쇼핑쇼핑"
    }

}

private extension NaverSearchViewController {
    
    func setRegister() {
        searchView.searchBar.delegate = self
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
