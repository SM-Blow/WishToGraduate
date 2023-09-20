//
//  CustomTextFieldView.swift
//  WishToGraduate
//
//  Created by KJ on 2023/09/20.
//

import UIKit

import SnapKit
import Then

enum CreateEventType {
    case eventName
    case hostName
    case eventDate
    case storeName
    case couponContent
    case dueDate
    case serialNumber
}

final class CustomTextFieldView: UIView {
    
    // MARK: - UI Components
    
    private let titleLabel = UILabel()
    private let textField = UITextField()
    private let textLimit = UILabel()
    
    // MARK: - Properties
    
    var maxLength: Int?
    var createEventType: CreateEventType?
    
    // MARK: - View Life Cycle
    
    init(type: CreateEventType) {
        super.init(frame: .zero)
        setUI()
        setLayout()
        setTextField(type)
        setDelegate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomTextFieldView {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        
        backgroundColor = .white
        
        titleLabel.do {
            $0.font = .fontGuide(.title)
            $0.textColor = .black
        }
        
        textField.do {
            $0.font = .fontGuide(.placeholder)
            $0.textColor = Color.placeholder_Grey
            $0.makeCornerRound(radius: 5)
            $0.makeBorder(width: 1, color: Color.circle_Grey)
            $0.setLeftPaddingPoints(11)
        }
        
        textLimit.do {
            $0.font = .systemFont(ofSize: 10, weight: .regular)
            $0.textColor = Color.placeholder_Grey
        }
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
        addSubviews(titleLabel, textField, textLimit)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        
        textField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(43)
        }
        
        textLimit.snp.makeConstraints {
            $0.top.equalTo(textField.snp.bottom).offset(2)
            $0.trailing.equalToSuperview()
        }
    }
    
    // MARK: - Methods
    
    private func setTextField(_ type: CreateEventType) {
        createEventType = type
        switch type {
        case .eventName:
            titleLabel.text = "행사 이름 *"
            textField.placeholder = "행사 이름을 작성해주세요."
            textLimit.text = "0/30"
            maxLength = 30
        case .hostName:
            titleLabel.text = "주최측 이름 *"
            textField.placeholder = "주최측 정보를 작성해주세요."
            textLimit.text = "0/20"
            maxLength = 20
        case .eventDate:
            titleLabel.text = "행사 일시 *"
            textField.placeholder = "행사의 일시를 선택해주세요."
        case .storeName:
            titleLabel.text = "가게 이름 *"
            textField.placeholder = "가게 이름을 작성해주세요."
            textLimit.text = "0/10"
            maxLength = 10
        case .couponContent:
            titleLabel.text = "쿠폰 내역 *"
            textField.placeholder = "ex). 현금 결제시 1000원 할인"
            textLimit.text = "0/20"
            maxLength = 20
        case .dueDate:
            titleLabel.text = "기한 *"
            textField.placeholder = "쿠폰의 사용 기한을 선택해주세요."
        case .serialNumber:
            titleLabel.text = "일련번호 *"
            textField.placeholder = "쿠폰에 적혀있는 8자리 일련번호를 작성해주세요."
            textLimit.text = "0/8"
            maxLength = 8
        }
    }
    
    private func setDelegate() {
        textField.delegate = self
    }
    
    // MARK: - @objc Methods
}

extension CustomTextFieldView: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.makeBorder(width: 1, color: Color.main_Green)
        textField.placeholder = ""
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        textField.makeBorder(width: 1, color: Color.main_Green)
        textField.placeholder = ""
        textField.font = .fontGuide(.title)
        textField.textColor = .black
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let maxLength = self.maxLength else { return true }

        let currentText = textField.text ?? ""
        let stringRange = Range(range, in: currentText) ?? currentText.startIndex..<currentText.endIndex
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        if updatedText.count <= maxLength {
            textLimit.text = "\(updatedText.count)/\(maxLength)"
            return true
        } else {
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if !textField.hasText {
            textField.makeBorder(width: 1, color: Color.circle_Grey)
            guard let type = createEventType else { return }
            switch type {
            case .eventName:
                textField.placeholder = "행사 이름을 작성해주세요."
                maxLength = 30
            case .hostName:
                textField.placeholder = "주최측 정보를 작성해주세요."
                maxLength = 20
            case .eventDate:
                textField.placeholder = "행사의 일시를 선택해주세요."
            case .storeName:
                textField.placeholder = "가게 이름을 작성해주세요."
            case .couponContent:
                textField.placeholder = "ex). 현금 결제시 1000원 할인"
            case .dueDate:
                textField.placeholder = "쿠폰의 사용 기한을 선택해주세요."
            case .serialNumber:
                textField.placeholder = "쿠폰에 적혀있는 8자리 일련번호를 작성해주세요."
            }
        } else {
            textField.makeBorder(width: 1, color: Color.main_Green)
        }
    }
}
