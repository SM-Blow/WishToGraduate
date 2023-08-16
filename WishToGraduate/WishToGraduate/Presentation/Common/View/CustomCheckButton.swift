//
//  CustomCheckButton.swift
//  WishToGraduate
//
//  Created by KJ on 2023/08/16.
//

import UIKit

enum CheckButtonState {
    case allow
    case notAllow
}

final class CheckButton: UIButton {
    
    // MARK: - Initializer
    
    init(title: String) {
        super.init(frame: .zero)
        setUI(title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Components Property
    
    func setUI(_ title: String) {
        layer.cornerRadius = 10
        titleLabel?.font = .fontGuide(.title_bold)
        titleLabel?.text = title
        setState(.allow)
    }
    
    // MARK: - Methods
    
    public func setState(_ state: CheckButtonState) {
        if state == .allow {
            setTitleColor(.white, for: .normal)
            backgroundColor = Color.main2_Green
            isUserInteractionEnabled = true
        } else {
            setTitleColor(.black, for: .normal)
            backgroundColor = Color.btn_Grey
            isUserInteractionEnabled = false
        }
    }
}

