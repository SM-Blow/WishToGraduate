//
//  HomeViewController.swift
//  WishToGraduate
//
//  Created by KJ on 2023/09/21.
//

import UIKit

import Moya
import SnapKit
import Then

final class HomeViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let navigationView = UIView()
    private let logoImageView = UIImageView()
    private let userNameLabel = UILabel()
    private let pointLabel = UILabel()
    private let shareButton = UIButton()
    private let couponButton = UIButton()
    private let eventButton = UIButton()
    private let myPageButton = UIButton()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
}

extension HomeViewController {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        
        view.backgroundColor = .white
        
        navigationView.do {
            $0.backgroundColor = Color.light_Green
        }
        
        logoImageView.do {
            $0.image = Image.profileImage
        }
        
        userNameLabel.do {
            $0.text = "반가워요 블로우님!"
            $0.font = .fontGuide(.title_bold)
            $0.textColor = .black
        }
        
        pointLabel.do {
            $0.text = "씨앗 개수: 5개"
            $0.font = .fontGuide(.title_bold)
            $0.textColor = .black
        }
        
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
    }
    
    // MARK: - Methods
    
    // MARK: - @objc Methods
}
