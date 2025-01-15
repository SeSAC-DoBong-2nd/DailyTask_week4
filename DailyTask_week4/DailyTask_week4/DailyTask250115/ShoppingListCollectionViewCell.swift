//
//  ShoppingListCollectionViewCell.swift
//  DailyTask_week4
//
//  Created by 박신영 on 1/15/25.
//

import UIKit

class ShoppingListCollectionViewCell: UICollectionViewCell {
    
    static let id = "ShoppingListCollectionViewCell"
    
    let imageView = UIImageView()
    let mallNameLabel = UILabel()
    let productLabel = UILabel()
    let priceLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setHierarchy()
        setLayout()
        setStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setHierarchy() {
        contentView.addSubviews(imageView,
                                mallNameLabel,
                                productLabel,
                                priceLabel)
    }
    
    func setLayout() {
        imageView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(self.snp.width)
        }
        
        mallNameLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(4)
            $0.leading.equalTo(imageView.snp.leading).offset(10)
        }
        
        productLabel.snp.makeConstraints {
            $0.top.equalTo(mallNameLabel.snp.bottom).offset(4)
            $0.leading.equalTo(mallNameLabel.snp.leading)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        priceLabel.snp.makeConstraints {
            $0.top.equalTo(productLabel.snp.bottom).offset(4)
            $0.leading.equalTo(mallNameLabel.snp.leading)
        }
    }
    
    func setStyle() {
    }
    
    func configureShppingListCell(imageUrl: String,
                                  shoppingMallName: String,
                                  productName: String,
                                  price: Int)
    {
        imageView.setImageKfDownSampling(with: imageUrl, cornerRadius: 20)
        
        mallNameLabel.setLabelUI(shoppingMallName,
                                     font: .systemFont(ofSize: 12, weight: .light),
                                     textColor: .lightGray)
        
        productLabel.setLabelUI(productName,
                                font: .systemFont(ofSize: 13, weight: .regular),
                                textColor: .white, numberOfLines: 2)
        
        priceLabel.setLabelUI(CustomFormatter.shard.setDecimalNumber(num: price),
                              font: .systemFont(ofSize: 16, weight: .medium),
                              textColor: .white)
    }
    
}
