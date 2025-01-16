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

final class NaverShoppingListViewController: BaseViewController {
    
    var searchText = "searchText"
    private var resultCount = 888
    private lazy var heartSelectedArr = Array(repeating: false, count: shoppingList.count)
    private var shoppingList: [Items] = [] {
        didSet {
            naverShoppingListView.shoppingCollectionView.reloadData()
            heartSelectedArr = Array(repeating: false, count: shoppingList.count)
        }
    }
    
    private let naverShoppingListView = NaverShoppingListView()
    
    override func loadView() {
        view = naverShoppingListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegate()
        view.backgroundColor = .black
    }
    
    override func viewWillAppear(_ animated: Bool) {
        naverShoppingListView.indicatorView.startAnimating()
        getNaverShoppingAPI(query: searchText, filter: nil)
    }
    
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
    
    func setDelegate() {
        naverShoppingListView.shoppingCollectionView.delegate = self
        naverShoppingListView.shoppingCollectionView.dataSource = self
        
        naverShoppingListView.buttonArr.forEach { i in
            i.addTarget(self, action: #selector(filterBtnTapped), for: .touchUpInside)
        }
    }
    
    func setSelectedButtonUI(_ sender: UIButton) {
        for i in naverShoppingListView.buttonArr {
            if i == sender {
                i.do {
                    $0.backgroundColor = .white
                    $0.setTitleColor(.black, for: .normal)
                }
            } else {
                i.do {
                    $0.backgroundColor = .black
                    $0.setTitleColor(.white, for: .normal)
                }
            }
        }
    }
    
    func getNaverShoppingAPI(query: String, filter: String?) {
        let url = "https://openapi.naver.com/v1/search/shop.json"
        let parameters = (filter == nil)
        ? ["query": query, "display": 100]
        : ["query": query, "display": 100, "sort": (filter ?? "")]
        
        guard let clientID = Bundle.main.naverClientId else {
            print("clientID 키를 로드하지 못했습니다.")
            return
        }
        
        guard let clientSecret = Bundle.main.naverClientSecret else {
            print("clientSecret 키를 로드하지 못했습니다.")
            return
        }
        
        AF.request(url,
                   method: .get,
                   parameters: parameters,
                   headers: [
                    HTTPHeader(name: "X-Naver-Client-Id", value: clientID),
                    HTTPHeader(name: "X-Naver-Client-Secret",value: clientSecret)
                   ]).responseDecodable(of: NaverShoppingResponseModel.self)
        { response in
            print(response)
            switch response.result {
                
            case .success(let result):
                print("success")
                
//                self.resultCount = result.total
//                let decimalCnt = CustomFormatter.shard.setDecimalNumber(num: self.resultCount)
                self.naverShoppingListView.resultCntLabel.text = "\(Int(result.total).formatted()) 개의 검색 결과"
                self.shoppingList = result.items
                self.naverShoppingListView.indicatorView.stopAnimating()
                
            case .failure(_):
                print("failure")
                
            }
        }
        
    }
    
    @objc
    func filterBtnTapped(_ sender: UIButton) {
        guard let title = sender.titleLabel?.text?.trimmingCharacters(in: .whitespaces) else {
            print("filterBtnTapped error")
            return
        }
        print(#function, title)
        
        setSelectedButtonUI(sender)
        
        switch title {
        case "정확도":
            getNaverShoppingAPI(query: searchText, filter: "sim")
        case "날짜순":
            getNaverShoppingAPI(query: searchText, filter: "date")
        case "가격높은순":
            getNaverShoppingAPI(query: searchText, filter: "dsc")
        case "가격낮은순":
            getNaverShoppingAPI(query: searchText, filter: "asc")
        default:
            print("default error")
        }
    }
    
    @objc
    func heartButtonTapped(_ sender: UIButton) {
        heartSelectedArr[sender.tag].toggle()
        switch heartSelectedArr[sender.tag] {
        case true:
            sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        case false:
            sender.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
    @objc
    func navLeftBtnTapped() {
        print(#function)
        navigationController?.popViewController(animated: true)
    }
    
}

extension NaverShoppingListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function, shoppingList[indexPath.item])
    }
    
}

extension NaverShoppingListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShoppingListCollectionViewCell.id, for: indexPath) as? ShoppingListCollectionViewCell else { return UICollectionViewCell() }
        
        let index = shoppingList[indexPath.item]
        cell.heartButton.tag = indexPath.item
        cell.heartButton.addTarget(self, action: #selector(heartButtonTapped), for: .touchUpInside)
        
        cell.configureShppingListCell(
            imageUrl: index.image,
            shoppingMallName: index.mallName,
            productName: index.title
                .replacingOccurrences(of: "<[^>]+>|&quot;",
                                      with: "",
                                      options: .regularExpression,
                                      range: nil),
            price: Int(index.lprice) ?? 0,
            isHeartBtnSelected: heartSelectedArr[indexPath.row]
        )
        
        return cell
    }
    
}
