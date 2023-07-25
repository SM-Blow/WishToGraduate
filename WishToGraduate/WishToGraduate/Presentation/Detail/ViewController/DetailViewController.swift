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

final class DetailViewController: UIViewController {
    
    enum DetailType: CaseIterable {
        case photo
        case text
    }
    
    enum StateType: CaseIterable {
        case yet
        case ing
        case end
    }
    
    private var detailType: DetailType = .text
    private var stateType: StateType = .yet
    
    // MARK: - UI Components
    
    private let backImageView = UIImageView()
    private let topUnderLineView = UIView()
    private let bottomUnderLineView = UIView()
    private let naviView = UIView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private let bottomButtonView = UIView()
    private let containerView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
    }
    
    private lazy var doubleCheckButton = UIButton(type: .system).then {
        $0.setTitle("거래 상태 바꾸기", for: .normal)
        $0.backgroundColor = Color.main2_Green
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = .fontGuide(.title_bold)
        $0.isEnabled = false
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
        $0.text = "두두"
        $0.textColor = .black
        $0.font = .fontGuide(.title_bold)
    }
    private let duedateLabel = UILabel().then {
        $0.text = "2023.05.20 13:30까지"
        $0.textColor = .black
        $0.font = .fontGuide(.h2)
    }
    private let untilLabel = UILabel().then {
        $0.text = "Until"
        $0.textColor = Color.main2_Green
        $0.font = .fontGuide(.h2_bold)
    }
    private let titleLabel = UILabel().then {
        $0.text = "생리대 중형 한 개"
        $0.textColor = .black
        $0.font = .fontGuide(.title_bold)
    }
    private let borrowLabel = BorrowLabel()
    private let transactionLabel = UILabel().then {
        $0.text = "거래중"
        $0.font = .fontGuide(.bt1)
        $0.textColor = .white
        $0.textAlignment = .center
        $0.backgroundColor = Color.main_Green
        $0.layer.cornerRadius = 3
        $0.clipsToBounds = true
    }
    
    private let contentLabel = UILabel().then {
        $0.text = "생리대 아무거나 중형 빌려요\n아무 브랜드 상관없어요\n지금 도서관인데 학교 어디든지 괜찮아요!"
        $0.font = .fontGuide(.h2)
        $0.textColor = .black
        $0.lineBreakMode = .byWordWrapping
        $0.numberOfLines = 0
    }
    private let photoImageView = UIImageView()
    
    // MARK: - Properties
    
    // MARK: - Initializer
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailType = .text
        stateType = .end
        setUI()
        photoOrTextLayout()
        setNavigationBar()
        setBorrowBtn()
        setTransactionLabel()
    }
}

extension DetailViewController {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        
        view.backgroundColor = Color.light_Green
        naviView.backgroundColor = .white
        headerView.backgroundColor = .white
        containerView.backgroundColor = .white
        backImageView.image = Image.backButton
        topUnderLineView.backgroundColor = Color.line_Grey
        bottomUnderLineView.backgroundColor = Color.line_Grey
        middleUnderLineView.backgroundColor = Color.line_Grey
        contentView.backgroundColor = Color.textview_Grey
        profileImageView.image = Image.profileImage
        photoImageView.image = Image.example
        
    }
    
    // MARK: - Methods
    
    private func setNavigationBar() {
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: Color.main_Green,
            .font: UIFont.fontGuide(.h1)
        ]
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: Image.backButton,
            style: .plain,
            target: self,
            action: #selector(backButtonTapped))
        navigationController?.navigationBar.tintColor = Color.main_Green
    }
    
    // 빌려요, 빌려줄게요 버튼 분기처리
    private func setBorrowBtn() {
        // 일단 1로 세팅
        let borrow = 1
        if (borrow == 1) {
            borrowLabel.labelStatus(status: .borrow2)
            borrowLabel.text = "빌려요"
        } else {
            borrowLabel.labelStatus(status: .lend2)
            borrowLabel.text = "빌려줄게요"
        }
    }
    
    private func setLayout() {
        
        bottomButtonView.addSubviews(doubleCheckButton)
        containerView.addSubviews(photoImageView, headerView, titleView, contentView, middleUnderLineView)
        contentView.addSubview(contentLabel)
        headerView.addSubviews(profileImageView, nicknameLabel, duedateLabel, untilLabel)
        titleView.addSubviews(titleLabel, borrowLabel, transactionLabel)
        view.addSubviews(topUnderLineView, naviView, containerView, bottomButtonView, bottomUnderLineView)
        
        topUnderLineView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(1)
        }
        
        naviView.snp.makeConstraints {
            $0.top.equalTo(topUnderLineView.snp.bottom)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(61)
        }

        containerView.snp.makeConstraints {
            $0.top.equalTo(topUnderLineView.snp.bottom)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }

        bottomButtonView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(81)
        }

        bottomUnderLineView.snp.makeConstraints {
            $0.top.equalTo(bottomButtonView.snp.top).offset(-1)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }

        doubleCheckButton.snp.makeConstraints {
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
    
    // MARK: - @objc Methods
    
    // 사진, 글만 있는 글 레이아웃 분기처리
    @objc
    private func photoOrTextLayout() {
        switch detailType {
        case .photo:
            setLayout()
        case .text:
            photoImageView.isHidden = true
            setLayout()
            DispatchQueue.main.async {
                self.setTextLayout()
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
        case .end:
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
    
    @objc
    private func backButtonTapped() {
        
    }
}
