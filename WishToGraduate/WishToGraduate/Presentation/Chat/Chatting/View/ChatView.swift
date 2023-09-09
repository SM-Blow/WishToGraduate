//
//  ChattingView.swift
//  WishToGraduate
//
//  Created by KJ on 2023/09/02.
//

import UIKit

import SnapKit
import Then

final class ChatView: UIView {
    
    // MARK: - UI Components
    
    private lazy var chatCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    // MARK: - Properties
    
    private let chatModel: [ChatModel] = ChatModel.chatModelDummyData()
    
    // MARK: - View Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
        setDelegate()
        setRegister()
        addKeyboardObserver()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ChatView {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        
        backgroundColor = .white
        
        chatCollectionView.do {
            $0.backgroundColor = .clear
        }
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
        addSubviews(chatCollectionView)
        
        chatCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK: - Methods
    
    private func setDelegate() {
        chatCollectionView.delegate = self
        chatCollectionView.dataSource = self
    }
    
    private func setRegister() {
        chatCollectionView.registerCell(ChatCollectionViewCell.self)
    }
    
    private func addKeyboardObserver() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
    }
    
    // MARK: - @objc Methods
    
    @objc
    private func keyboardWillShow(_ notification: NSNotification) {
        chatCollectionView.scrollToItem(at: IndexPath(row: chatModel.count - 1, section: 0), at: .top, animated: true)
    }
}

extension ChatView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let estimatedFrame = chatModel[indexPath.row].message.getEstimatedFrame(with: .fontGuide(.h2))
        return CGSize(width: bounds.width, height: estimatedFrame.height + 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 23
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 28, left: 0, bottom: 28, right: 0)
    }
}

extension ChatView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return chatModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(type: ChatCollectionViewCell.self, indexPath: indexPath)
        cell.setDataBind(chatModel[indexPath.row])
//        cell.remakeLayout(model: chatModel[indexPath.row])
        return cell
    }
}
