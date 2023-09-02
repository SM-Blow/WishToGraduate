//
//  ChattingViewController.swift
//  WishToGraduate
//
//  Created by KJ on 2023/09/02.
//

import UIKit

import Moya
import SnapKit
import Then

final class ChattingViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let chattingNavigationBar = CustomNavigationView(title: "")
    private let chattingView = ChattingView()
    private let messageFieldView = UIView()
    private let messageFieldLineView = UIView()
    private let inputTextFieldView = UITextField()
    private let sendButton = UIButton()
    
    // MARK: - Properties
    
    // MARK: - Initializer
    
    // MARK: - View Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        setTapScreen()
    }
}

extension ChattingViewController {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        
        view.backgroundColor = Color.light_Green
        
        chattingNavigationBar.do {
            $0.isBackButtonIncluded = true
        }
        
        messageFieldView.do {
            $0.backgroundColor = Color.light_Green
        }
        
        messageFieldLineView.do {
            $0.backgroundColor = Color.line_Grey
        }
        
        inputTextFieldView.do {
            $0.backgroundColor = .white
            $0.placeholder = "메시지를 입력하세요."
            $0.layer.cornerRadius = 20
            $0.clipsToBounds = true
            $0.font = .fontGuide(.h2)
            $0.textColor = Color.circle_Grey
            $0.setLeftPaddingPoints(16)
            $0.makeBorder(width: 1, color: Color.line_Grey)
        }
        
        sendButton.do {
            $0.setTitle("전송", for: .normal)
            $0.setTitleColor(Color.placeholder_Grey, for: .normal)
            $0.backgroundColor = .white
            $0.layer.cornerRadius = 20
            $0.clipsToBounds = true
            $0.titleLabel?.font = .fontGuide(.h2)
            $0.makeBorder(width: 1, color: Color.line_Grey)
        }
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
        messageFieldView.addSubviews(messageFieldLineView, inputTextFieldView, sendButton)
        view.addSubviews(chattingNavigationBar, chattingView, messageFieldView)
        
        chattingNavigationBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(52)
        }
        
        chattingView.snp.makeConstraints {
            $0.top.equalTo(chattingNavigationBar.snp.bottom)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(messageFieldView.snp.top)
        }
        
        messageFieldView.snp.makeConstraints {
            $0.bottom.equalTo(self.view.keyboardLayoutGuide.snp.top)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(61)
        }
        
        messageFieldLineView.snp.makeConstraints {
            $0.bottom.equalTo(messageFieldView.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        sendButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.trailing.equalToSuperview().inset(14)
            $0.width.equalTo(52)
            $0.height.equalTo(37)
        }
        
        inputTextFieldView.snp.makeConstraints {
            $0.top.equalTo(sendButton)
            $0.leading.equalToSuperview().inset(14)
            $0.trailing.equalTo(sendButton.snp.leading).offset(-13)
            $0.height.equalTo(37)
        }
    }
    
    // MARK: - Methods
    
    private func setTapScreen() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapScreen))
        tapGestureRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    // MARK: - @objc Methods
    
    @objc
    private func didTapScreen(_ gesture: UITapGestureRecognizer) {
        let touchLocation = gesture.location(in: self.view)
        if !messageFieldView.frame.contains(touchLocation) {
            self.view.endEditing(true)
        }
    }
}
