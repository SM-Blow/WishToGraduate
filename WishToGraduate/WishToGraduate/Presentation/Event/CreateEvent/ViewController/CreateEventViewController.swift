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
    
    // MARK: - UI Components
    
    private let navigationBar = CustomNavigationBar(title: "행사 생성하기")
    private let stackView = UIStackView()
    
    private let eventNameView = CreateEventTextField(type: .eventName)
    private let hostNameView = CreateEventTextField(type: .hostName)
    private let eventDetailView = UIView()
    private let eventDetailLabel = UILabel()
    private let eventDetailTextView = UITextView()
    private let eventDetailTextLimitLabel = UILabel()
    private let eventDateView = CreateEventTextField(type: .eventDate)
    
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
        stackView.addArrangedSubviews(eventNameView, hostNameView, eventDetailView, eventDateView)
        eventDetailView.addSubviews(eventDetailLabel, eventDetailTextView, eventDetailTextLimitLabel)
        
        navigationBar.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 96 / 812)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(19)
            $0.horizontalEdges.equalToSuperview().inset(23)
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 467 / 812)
        }
        
        eventNameView.snp.makeConstraints {
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 97 / 812)
        }
        
        hostNameView.snp.makeConstraints {
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 97 / 812)
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
    
    // MARK: - @objc Methods
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
        textView.makeBorder(width: 1, color: Color.circle_Grey)
    }
}
