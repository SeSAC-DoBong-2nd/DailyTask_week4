//
//  LotteryViewController.swift
//  DailyTask_week4
//
//  Created by 박신영 on 1/15/25.
//

import UIKit

import SnapKit
import Then
import Kingfisher
import Alamofire

class LotteryViewController: BaseViewController {
    
    //MARK: - UI Property
    let lottoTextField = UITextField()
    
    let introduceLabel = UILabel()
    let dateLabel = UILabel()
    let underLineView = UIView()
    
    let resultLabel = UILabel()
    let bonusLabel = UILabel()
    
    let ballStackView = UIStackView()
    let firstWinNumView = UIView()
    let secondWinNumView = UIView()
    let thirdWinNumView = UIView()
    let fourthWinNumView = UIView()
    let fifthWinNumView = UIView()
    let sixthWinNumView = UIView()
    let plusLabelView = UIView()
    let bonusWinNumView = UIView()
    
    let lottoPickerView = UIPickerView()
    
    //MARK: - Property
    let stackViewSpacing = 5
    
    let resultLabelText = "888회 당첨결과"
    
    //(screen width - (ballStackView inset 값 + spacing*7)) / 8
    lazy var ballSize = (UIScreen.main.bounds.width - CGFloat((30 + stackViewSpacing * 7))) / 8
    
    lazy var stackViewList = [
        firstWinNumView,
        secondWinNumView,
        thirdWinNumView,
        fourthWinNumView,
        fifthWinNumView,
        sixthWinNumView,
        plusLabelView,
        bonusWinNumView
    ]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setRegister()
        setResultLabelHilightColor(str: resultLabelText)
    }
    
    override func setHierarchy() {
        view.addSubviews(lottoTextField,
                         introduceLabel,
                         dateLabel,
                         underLineView,
                         resultLabel,
                         ballStackView,
                         bonusLabel)
        
        stackViewList.forEach { i in
            ballStackView.addArrangedSubview(i)
        }
    }
    
    override func setLayout() {
        lottoTextField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(30)
            $0.height.equalTo(40)
        }
        
        underLineView.snp.makeConstraints {
            $0.top.equalTo(lottoTextField.snp.bottom).offset(50)
            $0.horizontalEdges.equalToSuperview().inset(25)
            $0.height.equalTo(0.5)
        }
        
        introduceLabel.snp.makeConstraints {
            $0.bottom.equalTo(underLineView.snp.top).offset(-10)
            $0.leading.equalTo(underLineView.snp.leading)
        }
        
        dateLabel.snp.makeConstraints {
            $0.bottom.equalTo(introduceLabel.snp.bottom)
            $0.trailing.equalTo(underLineView.snp.trailing)
        }
        
        resultLabel.snp.makeConstraints {
            $0.top.equalTo(underLineView.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
        
        ballStackView.snp.makeConstraints {
            $0.top.equalTo(resultLabel.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(15)
        }
        
        
        stackViewList.forEach { i in
            i.snp.makeConstraints {
                $0.centerY.equalToSuperview()
                $0.size.equalTo(ballSize)
            }
        }
        
        bonusLabel.snp.makeConstraints {
            $0.top.equalTo(bonusWinNumView.snp.bottom).offset(5)
            $0.centerX.equalTo(bonusWinNumView.snp.centerX).offset(2)
        }
    }
    
    override func setStyle() {
        view.backgroundColor = .white
        
        lottoTextField.do {
            $0.layer.cornerRadius = 10
            $0.layer.borderColor = UIColor.lightGray.cgColor
            $0.layer.borderWidth = 0.5
            $0.textAlignment = .center
            $0.placeholder = "알고싶은 로또 회차를 선택해주세요."
            $0.font = .systemFont(ofSize: 14, weight: .black)
            $0.inputView = lottoPickerView
        }
        
        underLineView.backgroundColor = .lightGray
        
        introduceLabel.setLabelUI("당첨번호 안내", font: .systemFont(ofSize: 12, weight: .regular))
        
        dateLabel.setLabelUI("2888-88-88 추첨",
                             font: .systemFont(ofSize: 10, weight: .light),
                             textColor: .lightGray)
        
        resultLabel.setLabelUI("888회 당첨결과", font: .systemFont(ofSize: 22, weight: .black))
        
        ballStackView.do {
            $0.axis = .horizontal
            $0.spacing = CGFloat(stackViewSpacing)
            $0.alignment = .center
            $0.distribution = .fillEqually
        }
        
        stackViewList.forEach { i in
            if i != plusLabelView {
                i.do {
                    $0.backgroundColor = .yellow
                    $0.layer.cornerRadius = ballSize/2
                }
            }
        }
        
        bonusLabel.setLabelUI("보너스",
                              font: .systemFont(ofSize: 8),
                              alignment: .right)
    }

}

private extension LotteryViewController {
    
    func setRegister() {
        lottoTextField.delegate = self
        
        lottoPickerView.delegate = self
        lottoPickerView.dataSource = self
    }
    
    func setResultLabelHilightColor(str: String) {
        let attributedText = NSMutableAttributedString(
            string: str,
            attributes: [.font : UIFont.systemFont(ofSize: 22, weight: .black),]
        )
        
        let hilightLength = str.split(separator: " ")[0].count
        
        attributedText.addAttributes(
            [.foregroundColor : UIColor.systemYellow],
            range: NSRange(location: 0,length: hilightLength)
        )
        
        resultLabel.attributedText = attributedText
    }
    
    func getLottoAPI() {
        
    }
    
}

extension LotteryViewController: UITextFieldDelegate {
    
}

extension LotteryViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(#function)
        print(row.description)
        view.endEditing(true)
    }
    
}

extension LotteryViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 1154
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let arr = Array(1...1154)
        return String(arr.reversed()[row])
    }
    
}
