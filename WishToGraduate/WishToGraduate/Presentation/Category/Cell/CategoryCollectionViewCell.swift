//
//  CategoryCollectionViewCell.swift
//  WishToGraduate
//
//  Created by KJ on 2023/06/16.
//

import UIKit

import SnapKit
import Then

final class CategoryCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI Components
    
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    
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

extension CategoryCollectionViewCell {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        
        backgroundColor = .white
        layer.cornerRadius = 59 / 2
        clipsToBounds = true
        layer.shadowColor = Color.btn_darkGrey.cgColor
        layer.shadowOpacity = 0.08
        layer.shadowRadius = 5
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.masksToBounds = false
        
        titleLabel.do {
            $0.font = .fontGuide(.h4)
            $0.textColor = Color.circle_Grey
            $0.textAlignment = .center
            $0.addCharacterSpacing()
        }
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
        addSubviews(imageView, titleLabel)
        
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(4)
            $0.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(6)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(14)
        }
    }
    
    // MARK: - Methods
    
    func setDataBind(model: CategoryModel) {
        imageView.image = model.image
        titleLabel.text = model.title
    }
}
