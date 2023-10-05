//
//  DetailViewController.swift
//  WishToGraduate
//
//  Created by 고두영 on 2023/07/14.
//

import UIKit

import Moya
import SnapKit
import Then

enum UserType: CaseIterable {
    case mine
    case other
}

enum DetailType: CaseIterable {
    case photo
    case text
}

enum StateType: CaseIterable {
    case yet
    case ing
    case end
}

final class DetailViewController: UIViewController {
    
    // MARK: - Properties
    
    private var detailType: DetailType = .text
    private var stateType: StateType?
    private var userType: UserType?
    private var isScrapped: Bool = true {
        didSet {
            scrapImageView.image = isScrapped ? Image.scrapFill : Image.scrapEmpty
        }
    }
    private var postId: Int?
    
    // MARK: - UI Components
    
    private let navigationView = CustomNavigationBar(title: "").then {
        $0.isBackButtonIncluded = true
        $0.isReportButtonIncluded = true
    }
    private let bottomUnderLineView = UIView()
    private let naviView = UIView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private let bottomButtonView = UIView()
    private let containerView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
    }
    
    private lazy var bottomButton = UIButton(type: .system).then {
        $0.setTitle("거래 상태 바꾸기", for: .normal)
        $0.backgroundColor = Color.main2_Green
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = .fontGuide(.title_bold)
        $0.layer.cornerRadius = 10
    }
    
    private let headerView = UIView()
    private let titleView = UIView()
    private let contentView = UIView().then {
        $0.layer.cornerRadius = 20
    }
    private let middleUnderLineView = UIView()
    private let profileImageView = UIImageView()
    private let nicknameLabel = UILabel().then {
        $0.textColor = .black
        $0.font = .fontGuide(.title_bold)
    }
    private let duedateLabel = UILabel().then {
        $0.textColor = .black
        $0.font = .fontGuide(.h2)
    }
    private let untilLabel = UILabel().then {
        $0.textColor = Color.main2_Green
        $0.font = .fontGuide(.h2_bold)
    }
    private let titleLabel = UILabel().then {
        $0.textColor = .black
        $0.font = .fontGuide(.title_bold)
    }
    private let borrowLabel = CommonBorrowLabel(frame: .zero)
    private let transactionLabel = UILabel().then {
        $0.font = .fontGuide(.bt1)
        $0.textColor = .white
        $0.textAlignment = .center
        $0.backgroundColor = Color.main_Green
        $0.layer.cornerRadius = 3
        $0.clipsToBounds = true
    }
    
    private var contentLabel = UILabel().then {
        $0.font = .fontGuide(.h2)
        $0.textColor = .black
        $0.lineBreakMode = .byWordWrapping
        $0.numberOfLines = 0
    }
    private let photoImageView = UIImageView()
    private lazy var scrapImageView = UIImageView().then {
        $0.isUserInteractionEnabled = true
        $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(scrapButtonDidTapped)))
    }
    
    // MARK: - Initializer
    init(postId: Int) {
        super.init(nibName: nil, bundle: nil)
        self.postId = postId
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        requestGetPostDetail()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBottomButton()
        setUI()
        photoOrTextLayout()
        setButton()
    }
}

extension DetailViewController {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        
        view.backgroundColor = Color.light_Green
        naviView.backgroundColor = .white
        headerView.backgroundColor = .white
        containerView.backgroundColor = .white
        bottomUnderLineView.backgroundColor = Color.line_Grey
        middleUnderLineView.backgroundColor = Color.line_Grey
        contentView.backgroundColor = Color.textview_Grey
        profileImageView.image = Image.profileImage
        photoImageView.image = Image.example
        scrapImageView.image = isScrapped ? Image.scrapFill : Image.scrapEmpty
    }
    
    // MARK: - Methods
    
    private func setLayout() {
        
        bottomButtonView.addSubviews(bottomButton)
        containerView.addSubviews(photoImageView, headerView, titleView, contentView, middleUnderLineView)
        contentView.addSubview(contentLabel)
        headerView.addSubviews(profileImageView, nicknameLabel, duedateLabel, untilLabel)
        titleView.addSubviews(titleLabel, borrowLabel, transactionLabel, scrapImageView)
        view.addSubviews(navigationView, naviView, containerView, bottomButtonView, bottomUnderLineView)
        
        navigationView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 96 / 812)
        }
        
        naviView.snp.makeConstraints {
            $0.top.equalTo(navigationView.snp.bottom)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(61)
        }

        containerView.snp.makeConstraints {
            $0.top.equalTo(navigationView.snp.bottom)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }

        bottomButtonView.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(81)
        }

        bottomUnderLineView.snp.makeConstraints {
            $0.top.equalTo(bottomButtonView.snp.top).offset(-1)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }

        bottomButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15)
            $0.leading.trailing.equalToSuperview().inset(22)
            $0.height.equalTo(45)
        }
        
        photoImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.width.equalToSuperview()
            $0.height.equalTo(250)
        }
        
        headerView.snp.makeConstraints {
            $0.top.equalTo(photoImageView.snp.bottom)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(70)
        }
        
        middleUnderLineView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom)
            $0.leading.trailing.equalTo(headerView).inset(23)
            $0.height.equalTo(1)
        }
        
        titleView.snp.makeConstraints {
            $0.top.equalTo(middleUnderLineView.snp.bottom)
            $0.leading.trailing.equalTo(headerView)
            $0.height.equalTo(67)
        }

        contentView.snp.makeConstraints {
            $0.top.equalTo(titleView.snp.bottom)
            $0.leading.trailing.equalTo(headerView).inset(23)
            $0.height.equalTo(96)
            $0.bottom.equalToSuperview()
        }
        
        profileImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(23)
        }
        
        nicknameLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(profileImageView.snp.trailing).offset(15)
        }
        
        duedateLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(23)
        }
        
        untilLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(duedateLabel.snp.leading).offset(-7)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(23)
        }
        
        borrowLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(titleLabel.snp.trailing).offset(12)
        }
        
        transactionLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(borrowLabel.snp.trailing).offset(8)
            $0.width.equalTo(39)
            $0.height.equalTo(19)
        }
        
        scrapImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(22)
            $0.size.equalTo(22)
        }
        
        contentLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(14)
            $0.leading.equalToSuperview().offset(16)
        }
    }
    
    private func setTextLayout() {
        headerView.snp.remakeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(70)
        }
        self.view.setNeedsUpdateConstraints()
    }
    
    private func popToHome() {
        if let presentedViewController = self.presentedViewController as? ShareViewController {
            presentedViewController.requestGetPostList()
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    private func requestGetPostDetail() {
        PostAPI.shared.getPostDetail(postId: self.postId ?? 1) { [weak self] response in
            guard self != nil else { return }
            guard let data = response?.data else { return }
            self?.nicknameLabel.text = data.nickname
            self?.duedateLabel.text = "\(data.duedate[0]).\(data.duedate[1]).\(data.duedate[2]) \(data.duedate[3]):\(data.duedate[4])까지"
            self?.titleLabel.text = data.title
            self?.isScrapped = data.currentScrapStatus
            self?.borrowLabel.text = data.borrow ? "빌려요" : "빌려줄게요"
            self?.transactionLabel.text = data.status == 2 ? "거래중" : (data.status == 3 ? "거래 완료" : "")
            self?.stateType = data.status == 2 ? .ing : (data.status == 3 ? .end : .yet)
            self?.transactionLabel.isHidden = self?.transactionLabel.text == ""
            self?.setTransactionLabel()
            self?.contentLabel.text = data.content
        }
    }
    
    // MARK: - @objc Methods
    
    @objc
    private func setButton() {
        navigationView.backButtonHandler = { [weak self] in
            self?.popToHome()
        }
        
        navigationView.reportButtonHandler = { [weak self] in
            self?.navigationController?.pushViewController(ReportViewController(), animated: true)
        }
    }
    
    
    @objc
    private func scrapButtonDidTapped(_ gesture: UITapGestureRecognizer) {
        PostAPI.shared.postScrap(currentScrapStatus: self.isScrapped, targetPostId: self.postId!) { [weak self] response in
            guard self != nil else { return }
            guard let data = response?.data else { return }
            self?.postId = data.targetPostId
            self?.isScrapped = data.currentScrapStatus
        }
    }
    
    // 사진, 글만 있는 글 레이아웃 분기처리
    @objc
    private func photoOrTextLayout() {
        switch detailType {
        case .photo:
            setLayout()
        case .text:
            photoImageView.isHidden = true
            setLayout()
            DispatchQueue.main.async { [weak self] in
                self?.setTextLayout()
            }
        }
    }
    
    // 거래중, 완료 버튼 분기처리
    private func setTransactionLabel() {
        switch stateType {
        case .yet:
            transactionLabel.isHidden = true
        case .ing:
            transactionLabel.isHidden = false
            transactionLabel.text = "거래중"
            transactionLabel.backgroundColor = Color.main_Green
            
            transactionLabel.snp.remakeConstraints {
                $0.centerY.equalToSuperview()
                $0.leading.equalTo(borrowLabel.snp.trailing).offset(8)
                $0.width.equalTo(39)
                $0.height.equalTo(19)
            }
        default:
            transactionLabel.isHidden = false
            transactionLabel.text = "완료"
            transactionLabel.backgroundColor = Color.btn_darkGrey
            
            transactionLabel.snp.remakeConstraints {
                $0.centerY.equalToSuperview()
                $0.leading.equalTo(borrowLabel.snp.trailing).offset(8)
                $0.width.equalTo(30)
                $0.height.equalTo(19)
            }
        }
    }
    
    private func setBottomButton() {
        switch userType {
        case .other:
            bottomButton.setTitle("연락하기", for: .normal)
            bottomButton.addTarget(self, action: #selector(contactButtonTapped), for: .touchUpInside)
        default:
            bottomButton.setTitle("거래 상태 바꾸기", for: .normal)
            bottomButton.addTarget(self, action: #selector(changeTransactionState), for: .touchUpInside)
        }
    }
    
    private func requestChangeStatus() {
        let status = self.stateType == .yet ? 1 : (self.stateType == .ing) ? 2 : 3
        PostAPI.shared.patchUpdatePostStatus(postId: self.postId ?? 0, status: status) { [weak self] response in
            guard self != nil else { return }
            guard let data = response?.data else { return }
            self?.setTransactionLabel()
        }
    }
    
    @objc
    private func backButtonTapped() {
        print("이전")
    }
    
    @objc
    private func contactButtonTapped() {
        print("연락하러 갑시당")
    }
    
    @objc
    private func changeTransactionState(_ sender: UIButton) {
        
        let actionSheet = UIAlertController(title: nil, message: "해당하는 항목을 골라주세요.", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "거래전", style: .default, handler: {(ACTION: UIAlertAction) in
            print("거래전")
            self.stateType = .yet
            DispatchQueue.main.async { [weak self] in
                self?.requestChangeStatus()
                self?.setTransactionLabel()
            }
        }))
        
        actionSheet.addAction(UIAlertAction(title: "거래중", style: .default, handler: {(ACTION: UIAlertAction) in
            print("거래중")
            self.stateType = .ing
            DispatchQueue.main.async { [weak self] in
                self?.requestChangeStatus()
                self?.setTransactionLabel()
            }
        }))
        
        actionSheet.addAction(UIAlertAction(title: "거래완료", style: .default, handler: {(ACTION: UIAlertAction) in
            print("거래완료")
            self.stateType = .end
            DispatchQueue.main.async { [weak self] in
                self?.setTransactionLabel()
                self?.requestChangeStatus()
            }
        }))
        
        actionSheet.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
}
