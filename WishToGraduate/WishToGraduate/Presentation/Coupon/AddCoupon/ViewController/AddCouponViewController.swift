//
//  AddCouponViewController.swift
//  WishToGraduate
//
//  Created by KJ on 2023/09/20.
//

import UIKit

import Moya
import SnapKit
import Then

final class AddCouponViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let navigationBar = CustomNavigationBar(title: "쿠폰 등록")
    private let stackView = UIStackView()
    private let storeNameView = CustomTextFieldView(type: .storeName)
    private let couponContentView = CustomTextFieldView(type: .couponContent)
    private let dueDateView = CustomTextFieldView(type: .dueDate)
    private let serialNumberView = CustomTextFieldView(type: .serialNumber)
    private let addCouponButton = CustomButtonView(title: "쿠폰 등록하기")
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        setupKeyboardEvent()
        setTapScreen()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        removeKeyboardEvent()
    }
}

extension AddCouponViewController {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        
        view.backgroundColor = .white
        
        navigationBar.do {
            $0.isCloseButtonIncluded = true
        }
        
        stackView.do {
            $0.axis = .vertical
            $0.alignment = .fill
            $0.distribution = .equalCentering
        }
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
        view.addSubviews(navigationBar, stackView, addCouponButton)
        stackView.addArrangedSubviews(storeNameView, couponContentView, dueDateView, serialNumberView)
        
        navigationBar.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 96 / 812)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(18)
            $0.horizontalEdges.equalToSuperview().inset(23)
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 390 / 812)
        }
        
        storeNameView.snp.makeConstraints {
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 97 / 812)
        }
        
        couponContentView.snp.makeConstraints {
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 97 / 812)
        }
        
        dueDateView.snp.makeConstraints {
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 97 / 812)
        }
        
        serialNumberView.snp.makeConstraints {
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 97 / 812)
        }

        addCouponButton.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 81 / 812)
        }
    }
    
    // MARK: - Methods
    
    private func setupKeyboardEvent() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        
    }
    
    private func removeKeyboardEvent() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func setTapScreen() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapScreen))
        tapGestureRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    // MARK: - @objc Methods
    
    @objc
    private func keyboardWillShow(_ sender: Notification) {
        guard let keyboardFrame = sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let currentTextField = UIResponder.currentResponder as? UITextField else { return }
        let keyboardTopY = keyboardFrame.cgRectValue.origin.y
        let convertedTextFieldFrame = view.convert(currentTextField.frame, from: currentTextField.superview)
        let textFieldBottomY = convertedTextFieldFrame.origin.y + convertedTextFieldFrame.size.height
        
        if textFieldBottomY > keyboardTopY {
            let keyboardOverlap = textFieldBottomY - keyboardTopY
            view.frame.origin.y = -keyboardOverlap - 40
        }
    }
    
    @objc
    private func keyboardWillHide(_ sender: Notification) {
        if view.frame.origin.y != 0 {
            view.frame.origin.y = 0
        }
    }
    
    @objc
    private func didTapScreen(_ gesture: UITapGestureRecognizer) {
        let touchLocation = gesture.location(in: self.view)
        if !addCouponButton.frame.contains(touchLocation) {
            self.view.endEditing(true)
        }
    }
}
