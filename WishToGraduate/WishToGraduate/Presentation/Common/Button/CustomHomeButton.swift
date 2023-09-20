//
//  CustomHomeButton.swift
//  WishToGraduate
//
//  Created by KJ on 2023/09/21.
//

import UIKit

enum HomeButtonType {
    case share
    case coupon
    case event
    case myPage
}

final class CustomHomeButton: UIButton {
    
    // MARK: - Initializer

    init(_ type: HomeButtonType) {
        super.init(frame: .zero)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomHomeButton {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        
        makeCornerRound(radius: 15)
        makeShadow(radius: 8, offset: CGSize(width: 0, height: 0), opacity: 0.12)
        
        var config = UIButton.Configuration.filled()
        config.title = "공유하기"
        config.subtitle = "전자기기, 전공서적 등을 \n공유해요"
        config.image = Image.profileImage
        config.titleAlignment = .leading
        config.imagePlacement = NSDirectionalRectEdge.top
        configuration = config
    }
}
