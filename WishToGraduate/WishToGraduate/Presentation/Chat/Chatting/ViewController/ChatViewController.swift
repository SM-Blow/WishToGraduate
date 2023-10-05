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

final class ChatViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let navigationBar = CustomNavigationBar(title: "두두")
    private let chattingView = ChatView()
    private let messageFieldView = UIView()
    private let messageFieldLineView = UIView()
    private let inputTextFieldView = UITextField()
    private let sendButton = UIButton()
    
    // MARK: - View Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        setTapScreen()
        setDelegate()
        setAddTarget()
        setNavigationButton()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        removeKeyboardEvent()
    }
}

extension ChatViewController {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        
        view.backgroundColor = Color.light_Green
        
        navigationBar.do {
            $0.isBackButtonIncluded = true
            $0.isReportButtonIncluded = true
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
            $0.isUserInteractionEnabled = false
            $0.titleLabel?.font = .fontGuide(.h2)
            $0.makeBorder(width: 1, color: Color.line_Grey)
        }
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
        messageFieldView.addSubviews(messageFieldLineView, inputTextFieldView, sendButton)
        view.addSubviews(navigationBar, chattingView, messageFieldView)
        
        navigationBar.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 96 / 812)
        }
        
        chattingView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
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
    
    private func setDelegate() {
        inputTextFieldView.delegate = self
    }
    
    private func setAddTarget() {
        sendButton.addTarget(self, action: #selector(sendButtonDidTapped), for: .touchUpInside)
    }
    
    private func setTextFieldState(_ text: Bool) {
        if text {
            sendButtonSetState(true)
        } else {
            sendButtonSetState(false)
        }
    }
    
    private func sendButtonSetState(_ state: Bool) {
        if state {
            sendButton.setTitleColor(.black, for: .normal)
            sendButton.isUserInteractionEnabled = true
        } else {
            sendButton.setTitleColor(Color.placeholder_Grey, for: .normal)
            sendButton.isUserInteractionEnabled = false
        }
    }
    
    private func removeKeyboardEvent() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func popToChatList() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func pushToReportVC() {
        self.navigationController?.pushViewController(ReportViewController(), animated: true)
    }
    
    private func getInputText() -> String {
        return inputTextFieldView.text ?? ""
    }
    
    private func getCurrentTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let currentTime = dateFormatter.string(from: Date())
        return currentTime
    }
    
    // MARK: - @objc Methods
    
    @objc
    private func didTapScreen(_ gesture: UITapGestureRecognizer) {
        let touchLocation = gesture.location(in: self.view)
        if !messageFieldView.frame.contains(touchLocation) {
            self.view.endEditing(true)
        }
    }
    
    @objc
    private func sendButtonDidTapped() {
        print("전송버튼 탭")
        print(inputTextFieldView.text ?? "")
        print(chattingView.chatModel)
        chattingView.chatModel.append(ChatModel(message: getInputText(), chatType: .send, time: getCurrentTime()))
        chattingView.reloadChatCollectionView()
        inputTextFieldView.text = ""
        chattingView.scrollToBottom()
    }
    
    @objc
    private func setNavigationButton() {
        navigationBar.backButtonHandler = { [weak self] in
            self?.popToChatList()
        }
        navigationBar.reportButtonHandler = { [weak self] in
            self?.pushToReportVC()
        }
    }
}

extension ChatViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.placeholder = ""
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        textField.textColor = .black
        setTextFieldState(textField.hasText)
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        textField.placeholder = "메시지를 입력하세요."
        return true
    }
}
