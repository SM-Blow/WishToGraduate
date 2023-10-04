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
    var popHandler: (() -> Void)?
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        setTapScreen()
        setButton()
    }
}

extension AddCouponViewController {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        
        view.backgroundColor = .white
        
        navigationBar.do {
            $0.isCloseButtonIncluded = true
        }
        
        self.navigationController?.navigationBar.isHidden = true
        
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
    
    private func setTapScreen() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapScreen))
        tapGestureRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    private func popToHome() {
        self.dismiss(animated: true)
    }
    
    private func addCouponButtonDidTapped() {
        requestPostAddCoupon()
        popHandler?()
        navigationController?.popViewController(animated: true)
    }
    
    private func requestPostAddCoupon() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        if let date = dateFormatter.date(from: dueDateView.getText()) {
            // Date를 ISO 8601 형식의 문자열로 변환
            let isoDateFormatter = ISO8601DateFormatter()
            isoDateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
            let isoDateString = isoDateFormatter.string(from: date)
            CouponAPI.shared.postCouponAdd(
                storeName: storeNameView.getText(),
                content: couponContentView.getText(),
                dueDate: isoDateString,
                couponCode: serialNumberView.getText()) { [weak self] response in
                    guard self != nil else { return }
                    guard (response?.data) != nil else { return }
                }
        }
        
    }
    
    // MARK: - @objc Methods
    
    @objc
    private func didTapScreen(_ gesture: UITapGestureRecognizer) {
        let touchLocation = gesture.location(in: self.view)
        if !addCouponButton.frame.contains(touchLocation) {
            self.view.endEditing(true)
        }
    }
    
    @objc
    private func setButton() {
        navigationBar.closeButtonHandler = { [weak self] in
            self?.popToHome()
        }
        addCouponButton.buttonHandler = { [weak self] in
            self?.addCouponButtonDidTapped()
        }
    }
}
