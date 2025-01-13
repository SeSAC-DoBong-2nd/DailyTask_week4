//
//  MovieTableViewCell.swift
//  DailyTask_week4
//
//  Created by 박신영 on 1/13/25.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    //MARK: - Property
    static let identifier = "MovieTableViewCell"
    
    //MARK: - UI Property
    let rankView = UIView()
    let rankLabel = UILabel()
    let movieNameLabel = UILabel()
    let dateLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setHierarchy()
        setLayout()
        setStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setHierarchy() {
        contentView.addSubviews(rankView,
                                movieNameLabel,
                                dateLabel)
        
        rankView.addSubview(rankLabel)
    }
    
    func setLayout() {
        rankView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.verticalEdges.equalToSuperview().inset(8)
            $0.width.equalTo(42)
        }
        
        rankLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        movieNameLabel.snp.makeConstraints {
            $0.leading.equalTo(rankView.snp.trailing).offset(15)
            $0.width.equalTo(176)
            $0.centerY.equalTo(rankView.snp.centerY)
        }
        
        dateLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.centerY.equalTo(rankView.snp.centerY)
        }
    }
    
    func setStyle() {
        rankView.do {
            $0.backgroundColor = .white
        }
    }
    
    func configureMovieCell(rank: Int, movieName: String, date: String) {
        rankLabel.setLabelUI(String(rank), font: .boldSystemFont(ofSize: 16))
        
        movieNameLabel.setLabelUI(movieName, font: .boldSystemFont(ofSize: 16), textColor: .white)

        dateLabel.setLabelUI(date, font: .systemFont(ofSize: 14, weight: .light), textColor: .white, alignment: .right)
    }
    
}
