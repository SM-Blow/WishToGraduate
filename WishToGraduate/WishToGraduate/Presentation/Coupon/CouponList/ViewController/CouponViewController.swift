//
//  CouponViewController.swift
//  WishToGraduate
//
//  Created by 강윤서 on 2023/09/21.
//

import UIKit

import SnapKit
import Then

final class CouponViewController: UIViewController {

    // MARK: - Properties
    
    private let navigationBar = CustomNavigationBar(title: "쿠폰 관리하기")
    private lazy var coupontListCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    private var couponDummyData: [CouponListModel] = CouponListModel.couponListDummyData()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        setRegister()
        setDelegate()
        setButton()
    }
}

extension CouponViewController {
    private func setUI() {
        view.backgroundColor = .white
        
        navigationBar.do {
            $0.isBackButtonIncluded = true
        }
    }
    
    private func setLayout() {
        view.addSubviews(navigationBar, coupontListCollectionView)
        
        navigationBar.snp.makeConstraints {
            $0.top.directionalHorizontalEdges.equalToSuperview()
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 96 / 812)
        }
        
        coupontListCollectionView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.directionalHorizontalEdges.bottom.equalToSuperview()
        }
    }
    
    private func setRegister() {
        coupontListCollectionView.registerCell(AddCollectionViewCell.self)
        coupontListCollectionView.registerCell(CouponCollectionViewCell.self)
    }
    
    private func setDelegate() {
        coupontListCollectionView.dataSource = self
        coupontListCollectionView.delegate = self
    }
    
    private func backToHomeVC() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func useCoupon(title: String) {
        let alert = CustomAlertView(alertType: .useCoupon, title: title)
        alert.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(alert)
        alert.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        alert.isUserInteractionEnabled = true
    }
    
    @objc
    private func setButton() {
        navigationBar.backButtonHandler = { [weak self] in
            self?.backToHomeVC()
        }
    }
}

extension CouponViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: SizeLiterals.Screen.screenWidth - 40, height: 69)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 19
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        useCoupon(title: couponDummyData[indexPath.row].title)
    }
}

extension CouponViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return couponDummyData.count + 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row != couponDummyData.count {
            let cell = coupontListCollectionView.dequeueCell(type: CouponCollectionViewCell.self, indexPath: indexPath)
            cell.setData(couponDummyData[indexPath.row])
            return cell
        } else {
            let cell = coupontListCollectionView.dequeueCell(type: AddCollectionViewCell.self, indexPath: indexPath)
            return cell
        }
    }
}
