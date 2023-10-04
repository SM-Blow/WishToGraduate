//
//  HomeListView.swift
//  WishToGraduate
//
//  Created by KJ on 2023/06/16.
//

import UIKit

import SnapKit
import Then

final class ShareListView: UIView {
    
    // MARK: - UI Components
    
    lazy var listCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    // MARK: - Properties
    
    private var shareList: [Post] = []
    var pushToDetailHandler: (() -> Void)?
    
    // MARK: - View Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
        setDelegate()
        setRegister()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ShareListView {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        
        backgroundColor = .white
        
        listCollectionView.do {
            $0.backgroundColor = .clear
            $0.showsVerticalScrollIndicator = false
        }
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
        addSubviews(listCollectionView)
        
        listCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK: - Methods
    
    private func setDelegate() {
        listCollectionView.delegate = self
        listCollectionView.dataSource = self
    }
    
    private func setRegister() {
        listCollectionView.registerCell(ShareListCollectionViewCell.self)
    }
    
    func setListModel(category: CategorySection, model: [Post]) {
        switch category {
        case .all:
            shareList = model
        case .pill:
            shareList = []
        case .sanitaryPad:
            shareList = []
        case .charger:
            shareList = []
        case .book:
            shareList = []
        case .other:
            shareList = []
        }
        listCollectionView.reloadData()
    }
    
    func setSearchListModel(type: SearchSection, model: [Post]) {
        switch type {
        case .empty:
            shareList = []
        case .search:
            shareList = model
        }
        print(model)
        listCollectionView.reloadData()
    }
}

extension ShareListView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: bounds.width - 40, height: 69)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 14
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        pushToDetailHandler?()
    }
}

extension ShareListView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shareList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(type: ShareListCollectionViewCell.self, indexPath: indexPath)
        cell.setDataBind(shareList[indexPath.row])
        return cell
    }
}
