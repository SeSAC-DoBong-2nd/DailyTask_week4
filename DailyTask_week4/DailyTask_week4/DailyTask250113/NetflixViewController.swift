//
//  NetflixViewController.swift
//  DailyTask_week4
//
//  Created by 박신영 on 1/13/25.
//

import UIKit

import SnapKit
import Then

class NetflixViewController: UIViewController {
    
    let logoImageView = UIImageView()
    
    let stackView = UIStackView()
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let nicknameTextField = UITextField()
    let placeTextField = UITextField()
    let recommendCodeTextField = UITextField()
    
    let registerBtn = UIButton()
    
    let moreInfoLabel = UILabel()
    
    let toggleBtn = UISwitch()
    
    lazy var textFieldArr = [emailTextField, passwordTextField, nicknameTextField, placeTextField, recommendCodeTextField]

    override func viewDidLoad() {
        super.viewDidLoad()

        setHierarchy()
        setLayout()
        setStyle()
    }
    
    func setHierarchy() {
        view.addSubviews(logoImageView,
                         stackView,
                         registerBtn,
                         moreInfoLabel,
                         toggleBtn)
        
        textFieldArr.forEach {
            stackView.addArrangedSubview($0)
        }
    }
    
    func setLayout() {
        logoImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(150)
            $0.height.equalTo(50)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(160)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(270)
        }
        
        registerBtn.snp.makeConstraints {
            $0.top.equalTo(stackView.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }
        
        toggleBtn.snp.makeConstraints {
            $0.top.equalTo(registerBtn.snp.bottom).offset(20)
            $0.trailing.equalTo(registerBtn.snp.trailing).offset(-10)
            $0.width.equalTo(40)
            $0.height.equalTo(20)
        }
        
        moreInfoLabel.snp.makeConstraints {
            $0.top.equalTo(toggleBtn.snp.top)
            $0.leading.equalTo(registerBtn.snp.leading)
            $0.width.equalTo(100)
        }
    }
    
    func setStyle() {
        view.backgroundColor = .black
        
        navigationController?.navigationBar.isHidden = true
        
        logoImageView.setImageView(image: UIImage(resource: .wordmark), cornerRadius: 0)
        
        stackView.do {
            $0.spacing = 20
            $0.distribution = .fillEqually
            $0.axis = .vertical
            $0.backgroundColor = .clear
        }
        
        let textFieldText = ["이메일 주소 또는 전화번호", "비밀번호", "닉네임", "위치", "추천 코드 입력"]
        
        for i in 0..<textFieldArr.count {
            textFieldArr[i].do {
                $0.backgroundColor = ._250113TextFieldBackground
                $0.textAlignment = .center
                $0.text = textFieldText[i]
                $0.textColor = .white
                $0.layer.cornerRadius = 6
                $0.font = .systemFont(ofSize: 14, weight: .black)
            }
        }
        
        registerBtn.do {
            $0.setTitle("회원가입", for: .normal)
            $0.setTitleColor(.black, for: .normal)
            $0.titleLabel?.font = .boldSystemFont(ofSize: 18)
            $0.backgroundColor = .white
            $0.layer.cornerRadius = 8
        }
        
        moreInfoLabel.do {
            $0.setLabelUI("추가 정보 입력",
                          font: .systemFont(ofSize: 16, weight: .black),
                          textColor: .white)
        }
    }

}
