//
//  DetailViewController.swift
//  WishToGraduate
//
//  Created by 고두영 on 2023/07/14.
//

import UIKit

import Moya
import SnapKit
import Then

final class DetailViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let backImageView = UIImageView()
    private let topUnderLineView = UIView()
    private let bottomUnderLineView = UIView()
    private let  = UIView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
//    private let detailView = UIView()
    private let bottomButtonView = UIView()
    private let containerView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
    }
    
    private lazy var doubleCheckButton = UIButton(type: .system).then {
        $0.setTitle("거래 상태 바꾸기", for: .normal)
        $0.backgroundColor = Color.main2_Green
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = .fontGuide(.title_bold)
        $0.isEnabled = false
        $0.layer.cornerRadius = 10
    }
    
    // MARK: - Properties
    
    // MARK: - Initializer
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        setNavigationBar()
    }
}

extension DetailViewController {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        
        view.backgroundColor = Color.light_Green
        .backgroundColor = .white
        backImageView.image = Image.backButton
        topUnderLineView.backgroundColor = Color.line_Grey
        bottomUnderLineView.backgroundColor = Color.line_Grey
        
        // 임시
        containerView.backgroundColor = .white
        bottomButtonView.backgroundColor = .white
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
        bottomButtonView.addSubviews(doubleCheckButton)
        view.addSubviews(topUnderLineView, , containerView, bottomButtonView, bottomUnderLineView)
        
        topUnderLineView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(1)
        }
        
        .snp.makeConstraints {
            $0.top.equalTo(topUnderLineView.snp.bottom)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(61)
        }

        containerView.snp.makeConstraints {
            $0.top.equalTo(.snp.bottom)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }

        bottomButtonView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(81)
        }

        bottomUnderLineView.snp.makeConstraints {
            $0.top.equalTo(bottomButtonView.snp.top).offset(-1)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }

        doubleCheckButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15)
            $0.leading.trailing.equalToSuperview().inset(22)
            $0.height.equalTo(45)
        }
    }
    
    // MARK: - Methods
    
    private func setNavigationBar() {
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: Color.main_Green,
            .font: UIFont.fontGuide(.h1)
        ]
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: Image.backButton,
            style: .plain,
            target: self,
            action: #selector(backButtonTapped))
        navigationController?.navigationBar.tintColor = Color.main_Green
    }
    
    // MARK: - @objc Methods
    
    @objc
    private func backButtonTapped() {
//        popToHomeVC()
    }
}
