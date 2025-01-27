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
    private var currentFilter = ""
    private var resultCount = 888
    private var start = 1
    private var isEnd = false
    
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
        filterBtnTapped(naverShoppingListView.accuracyButton)
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
        naverShoppingListView.shoppingCollectionView.prefetchDataSource = self
        
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

    func getNaverShoppingAPI(query: String, start: Int, filter: String) {
        let url = "https://openapi.naver.com/v1/search/shop.json"
        let parameters = ["query": query, "display": 30, "start": start, "sort": filter] as [String : Any]
        
        guard let clientID = Bundle.main.naverClientId else {
            print("clientID 키를 로드하지 못했습니다.")
            return
        }
        
        guard let clientSecret = Bundle.main.naverClientSecret else {
            print("clientSecret 키를 로드하지 못했습니다.")
            return
        }
        
        NaverNetworkManager.shared.getNaverShoppingList(url: url,
                                                        parameters: parameters,
                                                        clientID: clientID,
                                                        clientSecret: clientSecret) { response, statusCode  in
            switch statusCode {
            case (200..<299):
                self.currentFilter = filter
                self.naverShoppingListView.resultCntLabel.text = "\(Int(response.total).formatted()) 개의 검색 결과"
                self.shoppingList.append(contentsOf: response.items)
                
                if self.start == 1 {
                    self.naverShoppingListView.shoppingCollectionView.scrollsToTop = true
                }
                
                //마지막 페이지 인식할 로직
                if (Int(response.total) - (start * 30)) < 0 {
                    self.isEnd = true
                }
                
                self.naverShoppingListView.indicatorView.stopAnimating()
            case (400..<499):
                print("클라 에러 대응")
                let alert = UIAlertUtil.showAlert(title: "요청 실패", message: "요청 값을 확인하여 주세요.")
                self.present(alert, animated: true)
            case (500...):
                print("서버 에러 대응")
                let alert = UIAlertUtil.showAlert(title: "요청 실패", message: "서버 에러")
                self.present(alert, animated: true)
            default:
                let alert = UIAlertUtil.showAlert(title: "요청 실패", message: "Error")
                self.present(alert, animated: true)
                print("에러 발생")
            }
            
        }
    }
    
    @objc
    func filterBtnTapped(_ sender: UIButton) {
        guard let title = sender.titleLabel?.text?.trimmingCharacters(in: .whitespaces) else {
            print("filterBtnTapped error")
            return
        }
        var currentBtnName: String {
            switch title {
            case "정확도":
                "sim"
            case "날짜순":
                "date"
            case "가격높은순":
                "dsc"
            case "가격낮은순":
                "asc"
            default:
                ""
            }
        }
        if currentBtnName != currentFilter {
            start = 1
            shoppingList.removeAll()
            setSelectedButtonUI(sender)
            getNaverShoppingAPI(query: searchText, start: self.start, filter: currentBtnName)
        }
         else {
            print("같은 버튼 눌렀지롱~")
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

extension NaverShoppingListViewController: UICollectionViewDataSourcePrefetching {
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        print(#function, indexPaths)
        for i in indexPaths {
            if (shoppingList.count - 6) == i.item && isEnd == false  {
                start += 1
                getNaverShoppingAPI(query: searchText, start: start, filter: currentFilter)
            }
        }
        
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShoppingListCollectionViewCell.cellIdentifier, for: indexPath) as? ShoppingListCollectionViewCell else { return UICollectionViewCell() }
        
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
