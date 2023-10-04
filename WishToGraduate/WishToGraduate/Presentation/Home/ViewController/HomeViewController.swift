//
//  HomeViewController.swift
//  WishToGraduate
//
//  Created by KJ on 2023/09/21.
//

import UIKit

import Moya
import SnapKit
import Then

final class HomeViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let navigationView = UIView()
    private let logoImageView = UIImageView()
    private let userNameLabel = UILabel()
    private let pointLabel = UILabel()
    private let shareButton = CustomHomeButton(.share)
    private let couponButton = CustomHomeButton(.coupon)
    private let eventButton = CustomHomeButton(.event)
    private let myPageButton = CustomHomeButton(.mypage)
    
    // MARK: - Properties
    
    private let homeProvider = MoyaProvider<UserService>(plugins: [NetworkLoggerPlugin(verbose: true)])
    private var homeUserModel: HomeUserModel = HomeUserModel(userName: "", point: 0)
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        setButton()
        fetchHome()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
}

extension HomeViewController {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        
        view.backgroundColor = .white
        
        navigationView.do {
            $0.backgroundColor = Color.light_Green
        }
        
        logoImageView.do {
            $0.image = Image.profileImage
        }
        
        userNameLabel.do {
            $0.text = "반가워요 블로우님!"
            $0.font = .fontGuide(.title_bold)
            $0.textColor = .black
        }
        
        pointLabel.do {
            $0.text = "씨앗 개수: 5개"
            $0.font = .fontGuide(.title_bold)
            $0.textColor = .black
        }
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
        view.addSubviews(navigationView, shareButton,
                         couponButton, eventButton, myPageButton)
        navigationView.addSubviews(logoImageView, userNameLabel, pointLabel)
        
        navigationView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 176 / 812)
        }
        
        logoImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(SizeLiterals.Screen.screenHeight * 44 / 812)
            $0.leading.equalToSuperview().inset(23)
            $0.size.equalTo(41)
        }
        
        userNameLabel.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().inset(31)
        }
        
        pointLabel.snp.makeConstraints {
            $0.top.equalTo(userNameLabel.snp.bottom).offset(5)
            $0.leading.equalTo(userNameLabel)
        }
        
        shareButton.snp.makeConstraints {
            $0.top.equalTo(navigationView.snp.bottom).offset(30)
            $0.leading.equalToSuperview().inset(SizeLiterals.Screen.screenWidth * 41 / 375)
            $0.width.equalTo(SizeLiterals.Screen.screenWidth * 131 / 375)
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 156 / 812)
        }
        
        couponButton.snp.makeConstraints {
            $0.top.equalTo(shareButton)
            $0.trailing.equalToSuperview().inset(SizeLiterals.Screen.screenWidth * 41 / 375)
            $0.width.equalTo(shareButton)
            $0.height.equalTo(shareButton)
        }
        
        eventButton.snp.makeConstraints {
            $0.top.equalTo(shareButton.snp.bottom).offset(30)
            $0.leading.equalTo(shareButton)
            $0.width.equalTo(shareButton)
            $0.height.equalTo(shareButton)
        }
        
        myPageButton.snp.makeConstraints {
            $0.top.equalTo(eventButton)
            $0.trailing.equalTo(couponButton)
            $0.width.equalTo(shareButton)
            $0.height.equalTo(shareButton)
        }
    }
    
    // MARK: - Methods
    
    private func setDataBind(_ model: HomeUserModel) {
        userNameLabel.text = "반가워요 \(model.userName)님!"
        userNameLabel.partColorChange(targetString: "\(model.userName)", textColor: Color.main_Green)
        pointLabel.text = "씨앗 개수: \(model.point)개"
        pointLabel.partColorChange(targetString: "\(model.point)", textColor: Color.main_Green)
    }
    
    private func pushToShareVC() {
        self.navigationController?.pushViewController(TabBarController(), animated: true)
    }
    
    private func pushToCouponVC() {
        self.navigationController?.pushViewController(CouponViewController(), animated: true)
    }
    
    private func pushToEventVC() {
        self.navigationController?.pushViewController(EventListViewController(), animated: true)
    }
    
    private func pushToMypage() {
        self.navigationController?.pushViewController(MyPageViewController(), animated: true)
    }
    
    // MARK: - @objc Methods
    
    private func setButton() {
        shareButton.shareButtonHandler = { [weak self] in
            self?.pushToShareVC()
        }
        couponButton.couponButtonHandler = { [weak self] in
            self?.pushToCouponVC()
        }
        eventButton.eventButtonHandler = { [weak self] in
            self?.pushToEventVC()
        }
        myPageButton.mypageButtonHadler = { [weak self] in
            self?.pushToMypage()
        }
    }
}

extension HomeViewController {
    
    private func fetchHome() {
        homeProvider.request(.home) { response in
            switch response {
            case .success(let result):
                let status = result.statusCode
                if status >= 200 && status < 300 {
                    do {
                        guard let home = try result.map(GeneralResponse<HomeResponse>.self).data else { return }
                        self.homeUserModel = home.convertToHome()
                        self.setDataBind(self.homeUserModel)
                    } catch(let error) {
                        print(error.localizedDescription)
                    }
                }
                else if status >= 400 {
                    print("400 error")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
