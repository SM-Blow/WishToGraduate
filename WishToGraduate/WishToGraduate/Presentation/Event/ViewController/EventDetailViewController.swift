//
//  EventDetailViewController.swift
//  WishToGraduate
//
//  Created by KJ on 2023/09/19.
//

import UIKit

import Moya
import SnapKit
import Then

final class EventDetailViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let navigationBar = CustomNavigationBar(title: "")
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    private let applicationButton = CustomButtonView(title: "행사 신청하기")
    
    private let userView = UIView()
    private let userProfileImageView = UIImageView()
    private let userNameLabel = UILabel()
    private let dateLabel = UILabel()
    private let dueDateLabel = UILabel()
    private let underLine = UIView()
    
    private let contentView = UIView()
    private let titleLabel = UILabel()
    private let applicantPersonLabel = UILabel()
    private let contentBackView = UIView()
    private let contentLabel = UILabel()
    
    // MARK: - Properties
    
    private var eventDetailDummy: EventDetailModel = EventDetailModel.eventDetailModelDummyData()
    
    // MARK: - View Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        setButton()
        setDateBind(eventDetailDummy)
    }
}

extension EventDetailViewController {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        
        view.backgroundColor = .white
        
        navigationBar.do {
            $0.isBackButtonIncluded = true
        }
        
        stackView.do {
            $0.axis = .vertical
            $0.distribution = .equalSpacing
            $0.alignment = .center
        }
        
        userProfileImageView.do {
            $0.image = Image.profileImage
        }
        
        userNameLabel.do {
            $0.font = .fontGuide(.title_bold)
            $0.textColor = .black
        }
        
        dateLabel.do {
            $0.font = .fontGuide(.h2_bold)
            $0.textColor = Color.main2_Green
        }
        
        dueDateLabel.do {
            $0.font = .fontGuide(.h2)
            $0.textColor = .black
        }
        
        underLine.do {
            $0.backgroundColor = Color.line_Grey
        }
        
        titleLabel.do {
            $0.font = .fontGuide(.m1)
            $0.textColor = .black
        }
        
        applicantPersonLabel.do {
            $0.font = .fontGuide(.bt1)
            $0.backgroundColor = Color.main_Green
            $0.textColor = .white
            $0.textAlignment = .center
            $0.makeCornerRound(radius: 3)
        }
        
        contentBackView.do {
            $0.backgroundColor = Color.textview_Grey
            $0.makeCornerRound(radius: 20)
        }
        
        contentLabel.do {
            $0.font = .fontGuide(.h2)
            $0.textColor = .black
            $0.numberOfLines = 0
        }
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
        userView.addSubviews(userProfileImageView, userNameLabel, dateLabel, dueDateLabel, underLine)
        contentBackView.addSubviews(contentLabel)
        contentView.addSubviews(titleLabel, applicantPersonLabel, contentBackView)
        stackView.addArrangedSubviews(userView, contentView)
        scrollView.addSubviews(stackView)
        view.addSubviews(navigationBar, scrollView, applicationButton)
        
        navigationBar.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 96 / 812)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview().inset(SizeLiterals.Screen.screenHeight * 81 / 812 + 11)
        }
        
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        userView.snp.makeConstraints {
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 70 / 812)
        }
        
        userProfileImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(23)
            $0.size.equalTo(46)
        }
        
        userNameLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(userProfileImageView.snp.trailing).offset(15)
        }
        
        dueDateLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(22)
        }
        
        dateLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(dueDateLabel.snp.leading).offset(-7)
        }
        
        underLine.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(22)
            $0.height.equalTo(1)
        }
        
        contentView.snp.makeConstraints {
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(21)
            $0.leading.equalToSuperview().inset(23)
        }
        
        applicantPersonLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel)
            $0.leading.equalTo(titleLabel.snp.trailing).offset(15)
            $0.width.equalTo(49)
            $0.height.equalTo(19)
        }
        
        contentBackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(27)
            $0.horizontalEdges.equalToSuperview().inset(22)
        }
        
        contentLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(14)
            $0.leading.equalToSuperview().inset(16)
        }
        
        applicationButton.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 81 / 812)
        }
    }
    
    // MARK: - Methods
    
    private func popToHome() {
        print("popToHome")
    }
    
    private func applicationButtonDidTapped() {
        let alert = CustomAlertView(alertType: .applicationEvent)
        alert.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(alert)
        alert.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        alert.isUserInteractionEnabled = true
    }
    
    private func setDateBind(_ model: EventDetailModel) {
        userNameLabel.text = model.userName
        dueDateLabel.text = model.date
        titleLabel.text = model.title
        applicantPersonLabel.text = model.applicantPersonLabel
        contentLabel.text = model.content
        setContentLayout(model.content)
    }
    
    private func setContentLayout(_ text: String) {
        guard let font = contentLabel.font else { return }
        let estimatedFrame = text.getEstimatedFrame(with: font)
        contentView.snp.makeConstraints {
            $0.height.equalTo(67 + estimatedFrame.height + 28)
        }
        contentBackView.snp.makeConstraints {
            $0.height.equalTo(estimatedFrame.height + 28)
        }
    }
    
    // MARK: - @objc Methods
    
    @objc
    private func setButton() {
        navigationBar.backButtonHandler = { [weak self] in
            self?.popToHome()
        }
        applicationButton.buttonHandler = { [weak self] in
            self?.applicationButtonDidTapped()
        }
    }
}
