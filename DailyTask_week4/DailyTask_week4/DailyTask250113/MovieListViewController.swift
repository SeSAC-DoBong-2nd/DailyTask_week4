//
//  MovieListViewController.swift
//  DailyTask_week4
//
//  Created by 박신영 on 1/13/25.
//

import UIKit

class MovieListViewController: UIViewController {
    
    //MARK: - Property
    let movieList = Movie.movieList
    
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
    }
    
    func setRegister() {
        movieTableView.delegate = self
        movieTableView.dataSource = self
        
        movieTableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.identifier)
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
        
        navigationController?.navigationBar.isHidden = true
        
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
            $0.text = "20200401"
        }
        
        searchBtn.do {
            $0.backgroundColor = .white
            $0.setTitle("검색", for: .normal)
            $0.setTitleColor(.black, for: .normal)
        }
    }
    
}

extension MovieListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(#function, movieList[indexPath.row])
        if let cell = tableView.cellForRow(at: indexPath) as? MovieTableViewCell {
            print(cell)
        }
    }
    
//    func tableView(_ tableView: UITableView, willDeselectRowAt indexPath: IndexPath) -> IndexPath? {
//        <#code#>
//    }
    
}

extension MovieListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier) as! MovieTableViewCell
        let movieRow = movieList[indexPath.row]
        cell.backgroundColor = .clear
        cell.configureMovieCell(rank: movieRow.rank, movieName: movieRow.title, date: movieRow.releaseDate)
        
        return cell
    }
    
}
