//
//  CreateEventViewController.swift
//  WishToGraduate
//
//  Created by KJ on 2023/09/20.
//

import UIKit

import Moya
import SnapKit
import Then

final class CreateEventViewController: UIViewController {
    
    var popHandler: (() -> Void)?
    
    // MARK: - UI Components
    
    private let navigationBar = CustomNavigationBar(title: "행사 생성하기")
    private let stackView = UIStackView()
    
    private let eventNameView = CustomTextFieldView(type: .eventName)
    private let hostNameView = CustomTextFieldView(type: .hostName)
    private let eventDetailView = UIView()
    private let eventDetailLabel = UILabel()
    private let eventDetailTextView = UITextView()
    private let eventDetailTextLimitLabel = UILabel()
    private let eventDateView = CustomTextFieldView(type: .eventDate)
    private let eventPeopleCountView = CustomTextFieldView(type: .eventPeople)
    
    private let createEventButton = CustomButtonView(title: "행사 생성하기")
    
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
        setDelegate()
        setupKeyboardEvent()
        setTapScreen()
        setButton()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        removeKeyboardEvent()
    }
}

extension CreateEventViewController {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        
        view.backgroundColor = .white
        
        navigationBar.do {
            $0.isCloseButtonIncluded = true
        }
        
        stackView.do {
            $0.axis = .vertical
            $0.distribution = .fill
            $0.alignment = .fill
        }
        
        eventDetailLabel.do {
            $0.text = "행사 내용 *"
            $0.font = .fontGuide(.title)
            $0.textColor = .black
        }
        
        eventDetailTextView.do {
            $0.font = .fontGuide(.placeholder)
            $0.textColor = Color.placeholder_Grey
            $0.makeCornerRound(radius: 5)
            $0.text = "행사 내용을 작성해주세요."
            $0.makeBorder(width: 1, color: Color.circle_Grey)
            $0.setLeftPaddingPoints(7)
        }
        
        eventDetailTextLimitLabel.do {
            $0.text = "0/200"
            $0.font = .systemFont(ofSize: 10, weight: .regular)
            $0.textColor = Color.placeholder_Grey
        }
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
        view.addSubviews(navigationBar, stackView, createEventButton)
        stackView.addArrangedSubviews(eventNameView, hostNameView, eventDetailView, eventDateView, eventPeopleCountView)
        eventDetailView.addSubviews(eventDetailLabel, eventDetailTextView, eventDetailTextLimitLabel)
        
        navigationBar.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 96 / 812)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(19)
            $0.horizontalEdges.equalToSuperview().inset(23)
            $0.bottom.equalToSuperview().inset(149)
        }
        
        [eventNameView, hostNameView, eventPeopleCountView].forEach {
            $0.snp.makeConstraints {
                $0.height.equalTo(SizeLiterals.Screen.screenHeight * 97 / 812)
            }
        }
        
        eventDetailView.snp.makeConstraints {
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 180 / 812)
        }
        
        eventDetailLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        
        eventDetailTextView.snp.makeConstraints {
            $0.top.equalTo(eventDetailLabel.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(122)
        }
        
        eventDetailTextLimitLabel.snp.makeConstraints {
            $0.top.equalTo(eventDetailTextView.snp.bottom).offset(2)
            $0.trailing.equalToSuperview()
        }
        
        eventDateView.snp.makeConstraints {
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 97 / 812)
        }
        
        createEventButton.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 81 / 812)
        }
    }
    
    // MARK: - Methods
    
    private func setDelegate() {
        eventDetailTextView.delegate = self
    }
    
    @objc
    private func addCouponButtonDidTapped() {
        requestPostAddEvent()
        popHandler?()
        self.dismiss(animated: true)
    }

    private func requestPostAddEvent() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        if let date = dateFormatter.date(from: eventDateView.getText()) {
            // Date를 ISO 8601 형식의 문자열로 변환
            let isoDateFormatter = ISO8601DateFormatter()
            isoDateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
            let isoDateString = isoDateFormatter.string(from: date)
            EventAPI.shared.postAddEvent(acceptCount: Int(eventPeopleCountView.getText())!,
                                         content: eventDetailTextView.text,
                                         dueDate: isoDateString,
                                         host: hostNameView.getText(),
                                         title: eventNameView.getText(),
                                         completion: { [weak self] response in
                guard self != nil else { return }
                guard (response?.data) != nil else { return }
            })
        }

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
    
    // MARK: - Methods
    
    private func setTapScreen() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapScreen))
        tapGestureRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    private func setButton() {
        navigationBar.closeButtonHandler = { [weak self] in
            self?.dismiss(animated: true)
        }
        createEventButton.buttonHandler = { [weak self] in
            self?.addCouponButtonDidTapped()
        }
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
        if !eventDetailTextView.frame.contains(touchLocation) {
            self.view.endEditing(true)
        }
    }
}

extension CreateEventViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.textColor == Color.placeholder_Grey {
            textView.text = ""
            textView.textColor = .black
            textView.makeBorder(width: 1, color: Color.main_Green)
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "행사 내용을 작성해주세요." {
            textView.text = ""
            textView.textColor = .black
            textView.makeBorder(width: 1, color: Color.main_Green)
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if !textView.hasText {
            textView.makeBorder(width: 1, color: Color.circle_Grey)
            textView.text = "행사 내용을 작성해주세요."
            textView.textColor = Color.placeholder_Grey
        } else {
            textView.makeBorder(width: 1, color: Color.main_Green)
        }
    }
}
