//
//  MyPageViewController.swift
//  WishToGraduate
//
//  Created by KJ on 2023/06/17.
//

import UIKit

import Moya
import SnapKit
import Then

final class MyPageViewController: UIViewController {
    
    private enum MyPageTab {
        case writing
        case scrap
    }
    
    // MARK: - UI Components
    
    private let navigationView = CustomNavigationBar(title: "마이페이지")
    private let myProfileView = MyProfileView()
    private let myPageSectionTab = MyPageSectionTab()
    private lazy var myWritingCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    // MARK: - Properties
    
    private var myPageTab: MyPageTab = .writing
    private var myPostDummyModel: [ShareListModel] = ShareListModel.myPostDummyData()
    private var myScrapDummyModel: [ShareListModel] = ShareListModel.myScrapDummyData()
    private var mypageModel: MypageModel = MypageModel.init(userId: 0, nickName: "", seed: 0, post: [], scrap: [])
    private let mypageProvider = MoyaProvider<UserService>(plugins: [NetworkLoggerPlugin(verbose: true)])
    
    
    // MARK: - View Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        fetchMypage()
        setDelegate()
        setRegister()
        setButton()
    }
}

extension MyPageViewController {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        
        view.backgroundColor = Color.light_Green
        
        navigationView.do {
            $0.isBackButtonIncluded = true
        }
        
        myWritingCollectionView.do {
            $0.backgroundColor = .clear
            $0.showsVerticalScrollIndicator = false
        }
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
        view.addSubviews(navigationView, myProfileView, myPageSectionTab, myWritingCollectionView)
        
        navigationView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 96 / 812)
        }
        
        myProfileView.snp.makeConstraints {
            $0.top.equalTo(navigationView.snp.bottom)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(235)
        }
        
        myPageSectionTab.snp.makeConstraints {
            $0.top.equalTo(myProfileView.snp.bottom)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(53)
        }
        
        myWritingCollectionView.snp.makeConstraints {
            $0.top.equalTo(myPageSectionTab.snp.bottom)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(500)
        }
    }
    
    // MARK: - Methods
    
    private func setDelegate() {
        myWritingCollectionView.delegate = self
//        myWritingCollectionView.dataSource = self
    }
    
    private func setRegister() {
        myWritingCollectionView.registerCell(ShareListCollectionViewCell.self)
    }
    
    private func popToHome() {
        navigationController?.popViewController(animated: true)
    }
    
    private func myWritingTab() {
        myPageTab = .writing
        myWritingCollectionView.reloadData()
    }
    
    private func myScarpTab() {
        myPageTab = .scrap
        myWritingCollectionView.reloadData()
    }
    
    private func pushToDetail() {
        self.navigationController?.pushViewController(DetailViewController(), animated: true)
    }
    
    // MARK: - @objc Methods
    
    @objc
    private func setButton() {
        navigationView.backButtonHandler = { [weak self] in
            self?.popToHome()
        }
        myPageSectionTab.myWritingButtonHandler = { [weak self] in
            self?.myWritingTab()
        }
        myPageSectionTab.myScarpButtonHandler = { [weak self] in
            self?.myScarpTab()
        }
    }
}

extension MyPageViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width - 40, height: 69)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 14
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        pushToDetail()
    }
}

//extension MyPageViewController: UICollectionViewDataSource {
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        switch (myPageTab) {
//        case .writing:
//            return myPostDummyModel.count
//        case .scrap:
//            return myScrapDummyModel.count
//        }
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueCell(type: ShareListCollectionViewCell.self, indexPath: indexPath)
//        switch (myPageTab) {
//        case .writing:
//            cell.setDataBind([model: myPostDummyModel[indexPath.row]])
//        case .scrap:
//            cell.setDataBind(model: myScrapDummyModel[indexPath.row])
//        }
//        return cell
//    }
//}

extension MyPageViewController {
    
    private func fetchMypage() {
        mypageProvider.request(.myPage) { response in
            switch response {
            case .success(let result):
                let status = result.statusCode
                if status >= 200 && status < 300 {
                    do {
                        guard let mypage = try result.map(GeneralResponse<MyPageResponse>.self).data else { return }
                        self.myProfileView.setDataBind(nickName: mypage.nickname, seed: mypage.seed)
                        self.myProfileView.setNeedsLayout()
                    } catch (let error) {
                        print(error.localizedDescription)
                    }
                }
                else if status >= 400 {
                    print("requestError")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
