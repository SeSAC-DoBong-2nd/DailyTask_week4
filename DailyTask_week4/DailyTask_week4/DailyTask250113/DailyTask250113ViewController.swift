//
//  DailyTask250113ViewController.swift
//  DailyTask_week4
//
//  Created by 박신영 on 1/13/25.
//

import UIKit

class DailyTask250113ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = ._250109Background
    }

    @IBAction
    func netflixBtnTapped(_ sender: UIButton) {
        print(#function)
        let vc = NetflixViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction
    func naverPayBtnTapped(_ sender: UIButton) {
        print(#function)
        let vc = NaverPayViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction
    func movieListBtnTapped(_ sender: UIButton) {
        print(#function)
        let vc = MovieListViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
