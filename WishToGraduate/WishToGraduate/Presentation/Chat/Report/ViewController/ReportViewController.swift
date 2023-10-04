//
//  ReportViewController.swift
//  WishToGraduate
//
//  Created by KJ on 2023/10/04.
//

import UIKit

import Moya
import SnapKit
import Then

final class ReportViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let navigationBar = CustomNavigationBar(title: "사용자 신고하기")
    private let reportTitleLabel = UILabel()
    private let reportTextView = UITextView()
    private let reportTextLimitLabel = UILabel()
    private let explainLabel = UILabel()
    private let reportButton = CustomButtonView(title: "신고하기")
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        setNavigationButton()
        setDelegate()
        setupKeyboardEvent()
        setTapScreen()
    }
}

extension ReportViewController {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        
        view.backgroundColor = .white
        
        navigationBar.do {
            $0.isBackButtonIncluded = true
        }
        
        reportTitleLabel.do {
            $0.text = "신고 사유 *"
            $0.font = .fontGuide(.title)
            $0.textColor = .black
        }
        
        reportTextView.do {
            $0.font = .fontGuide(.placeholder)
            $0.textColor = Color.placeholder_Grey
            $0.makeCornerRound(radius: 5)
            $0.text = "구체적인 신고 사유를 작성해주세요."
            $0.makeBorder(width: 1, color: Color.circle_Grey)
            $0.setLeftPaddingPoints(7)
        }
        
        reportTextLimitLabel.do {
            $0.text = "0/100"
            $0.font = .systemFont(ofSize: 10, weight: .regular)
            $0.textColor = Color.placeholder_Grey
        }
        
        explainLabel.do {
            $0.text = "신고하신 내용은 검토 후 빠른 시일 내 조치하겠습니다."
            $0.font = .fontGuide(.placeholder)
            $0.textColor = Color.main_Green
        }
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
        view.addSubviews(navigationBar, reportTitleLabel, reportTextView,
                         reportTextLimitLabel, explainLabel, reportButton)
        
        navigationBar.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 96 / 812)
        }
        
        reportTitleLabel.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(18)
            $0.leading.equalToSuperview().inset(23)
        }
        
        reportTextView.snp.makeConstraints {
            $0.top.equalTo(reportTitleLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(23)
            $0.height.equalTo(122)
        }
        
        reportTextLimitLabel.snp.makeConstraints {
            $0.top.equalTo(reportTextView.snp.bottom).offset(5)
            $0.trailing.equalToSuperview().inset(23)
        }
        
        reportButton.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 81 / 812)
        }
        
        explainLabel.snp.makeConstraints {
            $0.bottom.equalTo(reportButton.snp.top).offset(-15)
            $0.centerX.equalToSuperview()
        }
    }
    
    // MARK: - Methods
    
    private func popToChatVC() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setDelegate() {
        reportTextView.delegate = self
    }
    
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
    private func setNavigationButton() {
        navigationBar.backButtonHandler = { [weak self] in
            self?.popToChatVC()
        }
    }
    
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
        if !reportTextView.frame.contains(touchLocation) {
            self.view.endEditing(true)
        }
    }
}

extension ReportViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.textColor == Color.placeholder_Grey {
            textView.text = ""
            textView.textColor = .black
            textView.makeBorder(width: 1, color: Color.main_Green)
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "구체적인 신고 사유를 작성해주세요." {
            textView.text = ""
            textView.textColor = .black
            textView.makeBorder(width: 1, color: Color.main_Green)
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if !textView.hasText {
            textView.makeBorder(width: 1, color: Color.circle_Grey)
            textView.text = "구체적인 신고 사유를 작성해주세요."
            textView.textColor = Color.placeholder_Grey
        } else {
            textView.makeBorder(width: 1, color: Color.main_Green)
        }
    }
}
