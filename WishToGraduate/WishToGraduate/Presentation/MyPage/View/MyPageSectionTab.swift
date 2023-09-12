//
//  MyPageSectionTab.swift
//  WishToGraduate
//
//  Created by KJ on 2023/09/11.
//

import UIKit

import SnapKit
import Then

final class MyPageSectionTab: UIView {
    
    // MARK: - UI Components
    
    private let topLineView = UIView()
    private let myWritingButton = UIButton()
    private let myScrapButton = UIButton()
    private let centerLineView = UIView()
    private let underLineView = UIView()
    
    // MARK: - Properties
    
    var myWritingButtonHandler: (() -> Void)?
    var myScarpButtonHandler: (() -> Void)?
    
    // MARK: - Initializer
    
    // MARK: - View Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
        setAddTarget()
        setButton(button: myWritingButton, state: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MyPageSectionTab {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        
        backgroundColor = .white
        
        topLineView.do {
            $0.backgroundColor = Color.line_Grey
        }
        
        myWritingButton.do {
            $0.setTitle("내가 작성한 글", for: .normal)
            $0.setTitleColor(Color.placeholder_Grey, for: .normal)
            $0.titleLabel?.font = .fontGuide(.h3)
        }
        
        myScrapButton.do {
            $0.setTitle("내가 스크랩한 글", for: .normal)
            $0.setTitleColor(Color.placeholder_Grey, for: .normal)
            $0.titleLabel?.font = .fontGuide(.h3)
        }
        
        centerLineView.do {
            $0.backgroundColor = .white
        }
        
        underLineView.do {
            $0.backgroundColor = Color.line_Grey
        }
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
        addSubviews(topLineView, centerLineView, myWritingButton,
                    myScrapButton, underLineView)
        
        topLineView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        centerLineView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(1)
        }
        
        myWritingButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalTo(centerLineView.snp.leading)
            $0.height.equalTo(53)
        }
        
        myScrapButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(centerLineView.snp.trailing)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(53)
        }
        
        underLineView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
    
    // MARK: - Methods
    
    private func setAddTarget() {
        myWritingButton.addTarget(self, action: #selector(myWritingButtonDidTapped), for: .touchUpInside)
        myScrapButton.addTarget(self, action: #selector(myScrapButtonDidTapped), for: .touchUpInside)
    }
    
    private func setButton(button: UIButton, state: Bool) {
        if state {
            button.titleLabel?.font = .fontGuide(.m1)
            button.setTitleColor(Color.main_Green, for: .normal)
        } else {
            button.titleLabel?.font = .fontGuide(.h3)
            button.setTitleColor(Color.placeholder_Grey, for: .normal)
        }
    }
    
    // MARK: - @objc Methods
        
    @objc
    private func myWritingButtonDidTapped() {
        setButton(button: myWritingButton, state: true)
        setButton(button: myScrapButton, state: false)
        myWritingButtonHandler?()
    }
    
    @objc
    private func myScrapButtonDidTapped() {
        setButton(button: myScrapButton, state: true)
        setButton(button: myWritingButton, state: false)
        myScarpButtonHandler?()
    }
}
