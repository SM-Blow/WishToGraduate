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
    
    // MARK: - Initializer
    
    // MARK: - View Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
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
    
    // MARK: - @objc Methods
}
