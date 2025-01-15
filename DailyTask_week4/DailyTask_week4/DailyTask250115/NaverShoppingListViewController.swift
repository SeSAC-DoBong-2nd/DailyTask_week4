//
//  NaverShoppingListViewController.swift
//  DailyTask_week4
//
//  Created by 박신영 on 1/15/25.
//

import UIKit

import Alamofire
import Kingfisher
import SnapKit
import Then

class NaverShoppingListViewController: BaseViewController {
    
    let collectionViewInset = 10
    var searchText = "searchText"
    var resultCount = 888
//    var shoppingList = 
    
    let resultCntLabel = UILabel()
    let filterContainerView = UIView()
    let shoppingCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    

    override func viewDidLoad() {
        super.viewDidLoad()

        getNaverShoppingAPI(query: "캠핑카")
    }
    
    override func setHierarchy() {
        view.addSubviews(resultCntLabel,
                         filterContainerView,
                         shoppingCollectionView)
    }
    
    override func setLayout() {
        resultCntLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalToSuperview().offset(10)
        }
        
        filterContainerView.snp.makeConstraints {
            $0.top.equalTo(resultCntLabel.snp.bottom).offset(5)
            $0.leading.equalTo(resultCntLabel.snp.leading)
            $0.height.equalTo(50)
        }
        
        shoppingCollectionView.snp.makeConstraints {
            $0.top.equalTo(filterContainerView.snp.bottom).offset(5)
            $0.horizontalEdges.equalToSuperview().inset(collectionViewInset)
            $0.bottom.equalToSuperview()
        }
    }
    
    override func setStyle() {
        navigationController?.navigationBar.tintColor = .white
        
        navigationItem.title = searchText
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"),
                                                           style: .done,
                                                           target: self,
                                                           action: #selector(navLeftBtnTapped))
        
        resultCntLabel.setLabelUI("\(resultCount) 개의 검색 결과",
                                  font: .boldSystemFont(ofSize: 12),
                                  textColor: .systemGreen)
        
        filterContainerView.backgroundColor = .brown
        
        shoppingCollectionView.do {
            let itemSpacing: CGFloat = 15
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            layout.minimumInteritemSpacing = itemSpacing
            let widthAbleSize = (UIScreen.main.bounds.width - itemSpacing - CGFloat(collectionViewInset * 2)) / 2
            layout.itemSize = CGSize(width: widthAbleSize/2, height: widthAbleSize/2 + 40)
            $0.collectionViewLayout = layout
            $0.backgroundColor = .clear
        }
    }

}

private extension NaverShoppingListViewController {
    
    func setRegister() {
        shoppingCollectionView.delegate = self
        shoppingCollectionView.dataSource = self
        
        shoppingCollectionView.register(ShoppingListCollectionViewCell.self, forCellWithReuseIdentifier: ShoppingListCollectionViewCell.id)
    }
    
    func getNaverShoppingAPI(query: String) {
        let url = "https://openapi.naver.com/v1/search/shop.json?query=\(query)"
        AF.request(url, method: .get, parameters: ["display": 100], headers: [HTTPHeader(name: "X-Naver-Client-Id", value: "ZFh8lFuSTE0h9CfYE75T"), HTTPHeader(name: "X-Naver-Client-Secret", value: "AcXJVWd0OY")]).responseString { response in
            print(response)
        }
    }
    
    @objc
    func navLeftBtnTapped() {
        print(#function)
        navigationController?.popViewController(animated: true)
    }
    
}

extension NaverShoppingListViewController: UICollectionViewDelegate {
    
}

extension NaverShoppingListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShoppingListCollectionViewCell.id, for: indexPath) as! ShoppingListCollectionViewCell
        
        return cell
    }
    
    
}
