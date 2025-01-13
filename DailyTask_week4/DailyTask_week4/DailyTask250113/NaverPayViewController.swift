//
//  NaverPayViewController.swift
//  DailyTask_week4
//
//  Created by 박신영 on 1/13/25.
//

import UIKit

class NaverPayViewController: UIViewController {
    
    let topContainerView = UIView()
    
    let topTappedView = UIView()
    let onSitePaymentLabel = UILabel()
    
    let membershipLabel = UILabel()
    let couponLabel = UILabel()
    
    let mainContainerView = UIView()
    let naverpayLogoImageView = UIImageView()
    let placeLabel = UILabel()
    let cancelBtn = UIButton()
    let naverpayLockImageView = UIImageView()
    let commentLabel = UILabel()
    let checkImageView = UIImageView()
    let checkLabel = UILabel()
    let doneBtn = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        setHierarchy()
        setLayout()
        setStyle()
    }
    
    func setHierarchy() {
        view.addSubviews(topContainerView, mainContainerView)
        
        topContainerView.addSubviews(membershipLabel,
                                     topTappedView,
                                     couponLabel)
        
        topTappedView.addSubview(onSitePaymentLabel)
        
        mainContainerView.addSubviews(naverpayLogoImageView,
                                      placeLabel,
                                      cancelBtn,
                                      naverpayLockImageView,
                                      commentLabel,
                                      checkImageView,
                                      checkLabel,
                                      doneBtn)
    }
    
    func setLayout() {
        topContainerView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(40)
        }
        
        topTappedView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.verticalEdges.equalToSuperview().inset(5)
            $0.width.equalTo(100)
        }
        
        onSitePaymentLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        membershipLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(40)
        }
        
        couponLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-40)
        }
        
        mainContainerView.snp.makeConstraints {
            $0.top.equalTo(topContainerView.snp.bottom).offset(30)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().offset(-250)
        }
        
        naverpayLogoImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(10)
            $0.width.equalTo(90)
            $0.height.equalTo(60)
        }
        
        placeLabel.snp.makeConstraints {
            $0.leading.equalTo(naverpayLogoImageView.snp.trailing).offset(-2)
            $0.centerY.equalTo(naverpayLogoImageView.snp.centerY)
        }
        
        cancelBtn.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalTo(placeLabel.snp.bottom)
            $0.size.equalTo(30)
        }
        
        naverpayLockImageView.snp.makeConstraints {
            $0.top.equalTo(placeLabel.snp.bottom).offset(35)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(90)
            $0.height.equalTo(120)
        }
        
        commentLabel.snp.makeConstraints {
            $0.top.equalTo(naverpayLockImageView.snp.bottom).offset(15)
            $0.centerX.equalToSuperview()
        }
        
        doneBtn.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().offset(-20)
            $0.height.equalTo(45)
        }
        
        checkImageView.snp.makeConstraints {
            $0.bottom.equalTo(doneBtn.snp.top).offset(-30)
            $0.centerX.equalToSuperview().offset(-65)
            $0.size.equalTo(25)
        }
        
        checkLabel.snp.makeConstraints {
            $0.centerY.equalTo(checkImageView.snp.centerY)
            $0.leading.equalTo(checkImageView.snp.trailing).offset(7)
        }
    }
    
    func setStyle() {
        view.backgroundColor = ._250113NaverpayViewBackgorund
        
        topContainerView.do {
            $0.backgroundColor = .black
            $0.layer.cornerRadius = 20
        }
        
        topTappedView.do {
            $0.backgroundColor = .darkGray
            $0.layer.cornerRadius = 14
        }
        
        onSitePaymentLabel.setLabelUI("현장결제",
                                      font: .systemFont(ofSize: 17, weight: .heavy),
                                   textColor: .white)
        
        membershipLabel.setLabelUI("멤버십",
                                   font: .boldSystemFont(ofSize: 16),
                                   textColor: .white.withAlphaComponent(0.6))
        
        couponLabel.setLabelUI("쿠폰",
                                   font: .boldSystemFont(ofSize: 16),
                               textColor: .white.withAlphaComponent(0.6), alignment: .right)
        
        mainContainerView.do {
            $0.backgroundColor = .white
            $0.layer.cornerRadius = 20
        }
        
        naverpayLogoImageView.do {
            $0.image = UIImage(resource: .naverpayLogo)
            $0.contentMode = .scaleAspectFill
        }
        
        placeLabel.setLabelUI("국내 ▼", font: .systemFont(ofSize: 14, weight: .regular), textColor: .lightGray)
        
        cancelBtn.do {
            $0.setImage(UIImage(systemName: "x.circle"), for: .normal)
            $0.tintColor = .black
            $0.imageView?.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
        }
        
        naverpayLockImageView.setImageView(image: UIImage(resource: .naverpayLock), cornerRadius: 0)
        
        commentLabel.setLabelUI("한 번만 인증하고\n비밀번호 없이 결제하세요",
                                font: .boldSystemFont(ofSize: 20),
                                alignment: .center,
                                numberOfLines: 2)
        
        doneBtn.do {
            $0.backgroundColor = .naverpayDoneBtn
            $0.setTitle("확인", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.titleLabel?.font = .boldSystemFont(ofSize: 16)
            $0.layer.cornerRadius = 20
        }
        
        checkImageView.do {
            $0.image = UIImage(systemName: "checkmark.circle.fill")
            $0.tintColor = .naverpayDoneBtn
        }
        
        checkLabel.setLabelUI("바로 결제 사용하기", font: .systemFont(ofSize: 16, weight: .black))
    }

}
