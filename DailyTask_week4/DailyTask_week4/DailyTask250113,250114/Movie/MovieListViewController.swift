//
//  MovieListViewController.swift
//  DailyTask_week4
//
//  Created by 박신영 on 1/13/25.
//

import UIKit

import SnapKit
import Then
import Alamofire

class MovieListViewController: UIViewController {
    
    //MARK: - Property
    var movieList: [DailyBoxOfficeList] = [] {
        didSet {
            movieTableView.reloadData()
        }
    }
    
    var currentTextFieldText = ""
    
    //MARK: - UI Property
    let underLineView = UIView()
    let textField = UITextField()
    let searchBtn = UIButton()
    
    let movieTableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()

        setRegister()
        setHierarchy()
        setLayout()
        setStyle()
        getMovieList(date: returnYesterday())
    }
    
    func setRegister() {
        textField.delegate = self
        
        movieTableView.delegate = self
        movieTableView.dataSource = self
        
        movieTableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.identifier)
        
        searchBtn.addTarget(self, action: #selector(searchBtnTapped), for: .touchUpInside)
    }
    
    func setHierarchy() {
        view.addSubviews(underLineView,
                         textField,
                         searchBtn,
                         movieTableView)
    }
    
    func setLayout() {
        underLineView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(90)
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalTo(searchBtn.snp.leading).offset(-15)
            $0.height.equalTo(2)
        }
        
        textField.snp.makeConstraints {
            $0.bottom.equalTo(underLineView.snp.top).offset(-5)
            $0.leading.width.equalTo(underLineView)
        }
        
        searchBtn.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-10)
            $0.bottom.equalTo(underLineView.snp.bottom)
            $0.width.equalTo(90)
            $0.height.equalTo(60)
        }
        
        movieTableView.snp.makeConstraints {
            $0.top.equalTo(underLineView.snp.bottom).offset(15)
            $0.horizontalEdges.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview()
        }
        movieTableView.rowHeight = 45
    }
    
    func setStyle() {
        view.backgroundColor = ._250113NaverpayViewBackgorund
        
        underLineView.backgroundColor = .white
        
        movieTableView.do {
            $0.backgroundColor = .clear
            $0.separatorStyle = .none
        }
        
        textField.do {
            $0.borderStyle = .none
            $0.textColor = .white
            $0.textAlignment = .left
            $0.font = .systemFont(ofSize: 18, weight: .light)
            $0.text = ""
        }
        
        searchBtn.do {
            $0.backgroundColor = .white
            $0.setTitle("검색", for: .normal)
            $0.setTitleColor(.black, for: .normal)
        }
    }
    
}

private extension MovieListViewController {
    
    func returnYesterday() -> String {
        let dateFormat = CustomFormatter.shard.dateFormatter
        dateFormat.dateFormat = "yyyyMMdd"
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())
        
        return dateFormat.string(from: yesterday ?? Date())
    }
    
    func getMovieList(date: String) {
        guard let apiKey = Bundle.main.apiKey else {
            print("API 키를 로드하지 못했습니다.")
            return
        }
        
        let url = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(apiKey)&targetDt=\(date)"
        
        AF.request(url, method: .get).responseDecodable(of: MovieResponseModel.self) { response in
            switch response.result {
            case .success(let result):
                print(result)
                self.textField.text = String(result.boxOfficeResult.showRange.split(separator: "~")[0])
                if result.boxOfficeResult.dailyBoxOfficeList.isEmpty {
                    let alert = UIAlertUtil.showAlert(title: "조회 실패", message: "조금 더 최신 일자를 검색하여 주세요.")
                    self.present(alert, animated: true)
                } else {
                    self.movieList = result.boxOfficeResult.dailyBoxOfficeList
                }
            case .failure(let error):
                print(error)
                let alert = UIAlertUtil.showAlert(title: "조회 실패", message: "다시 시도하여 주세요.")
                self.present(alert, animated: true)
            }
        }
    }
    
    @objc
    func searchBtnTapped() {
        view.endEditing(true)
        
        let dateFormat = CustomFormatter.shard.dateFormatter
        dateFormat.dateFormat = "yyyyMMdd"
        if dateFormat.date(from: currentTextFieldText) != nil {
            getMovieList(date: textField.text ?? "")
        } else {
            let alert = UIAlertUtil.showAlert(title: "조회 실패", message: "yyyyMMdd 형식으로 알맞게 입력하여 주세요.")
            self.present(alert, animated: true)
        }
    }
    
}

extension MovieListViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(#function)
        searchBtnTapped()
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        currentTextFieldText = textField.text ?? ""
    }
    
}

extension MovieListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(#function, movieList[indexPath.row])
        if let cell = tableView.cellForRow(at: indexPath) as? MovieTableViewCell {
            print(cell)
        }
    }
    
}

extension MovieListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier) as! MovieTableViewCell
        let movieRow = movieList[indexPath.row]
        cell.backgroundColor = .clear
        cell.configureMovieCell(rank: Int(movieRow.rank) ?? 0, movieName: movieRow.movieNm, date: movieRow.openDt)
        
        return cell
    }
    
}
