//
//  CreateEventTextField.swift
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
}

final class CreateEventTextField: UIView {
    
    // MARK: - UI Components
    
    private let titleLabel = UILabel()
    private let textField = UITextField()
    private let textLimit = UILabel()
    
    // MARK: - Properties
    
    var maxLength: Int?
    
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

extension CreateEventTextField {
    
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
        }
    }
    
    private func setDelegate() {
        textField.delegate = self
    }
    
    // MARK: - @objc Methods
}

extension CreateEventTextField: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.makeBorder(width: 1, color: Color.main_Green)
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
        textField.makeBorder(width: 1, color: Color.circle_Grey)
    }
}
