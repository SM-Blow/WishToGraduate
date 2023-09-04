//
//  ChatCollectionViewCell.swift
//  WishToGraduate
//
//  Created by KJ on 2023/09/03.
//

import UIKit

import SnapKit
import Then

final class ChatCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI Components
    
    private let messageTextView = UITextView()
    private let timeLabel = UILabel()
    
    // MARK: - Properties
    
//    var chatType: ChatType? {
//        didSet {
//            switch chatType {
//            case .send:
//                messageTextView.backgroundColor = .white
//                messageTextView.snp.makeConstraints {
//                    $0.leading.equalToSuperview().inset(23)
//                }
//                timeLabel.snp.makeConstraints {
//                    $0.leading.equalTo(messageTextView.snp.trailing).offset(6)
//                }
//            case .receive:
//                messageTextView.backgroundColor = Color.light_Green
//                messageTextView.snp.makeConstraints {
//                    $0.trailing.equalToSuperview().inset(23)
//                }
//                timeLabel.snp.makeConstraints {
//                    $0.trailing.equalTo(messageTextView.snp.leading).offset(-6)
//                }
//            case .none:
//                return
//            }
//        }
//    }
    
    // MARK: - View Life Cycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
//        setEstimatedFrame()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
//        setEstimatedFrame()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ChatCollectionViewCell {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        
        backgroundColor = .white
        
        messageTextView.do {
            $0.font = .fontGuide(.h2)
            $0.textColor = .black
            $0.backgroundColor = .white
            $0.layer.cornerRadius = 10
            $0.clipsToBounds = true
            $0.textAlignment = .natural
            $0.isEditable = false
            $0.makeShadow(radius: 8, offset: CGSize(width: 0, height: 0), opacity: 0.12)
        }
        
        timeLabel.do {
            $0.font = .fontGuide(.date1)
            $0.textColor = Color.placeholder_Grey
            $0.text = "14:45"
        }
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
        addSubviews(messageTextView, timeLabel)
        
        messageTextView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
        }
        
        timeLabel.snp.makeConstraints {
            $0.bottom.equalTo(messageTextView)
        }
    }
    
    func setEstimatedFrame() {
        if let text = messageTextView.text {
            guard let font = messageTextView.font else { return }
            let estimatedFrame = text.getEstimatedFrame(with: font)
            messageTextView.snp.makeConstraints {
                $0.width.equalTo(estimatedFrame.width + 22)
            }
        }
    }
    
    // MARK: - Methods
    
    func setDataBind(_ model: ChatModel) {
        guard let font = messageTextView.font else { return }
        messageTextView.text = model.message
        let estimatedFrame = model.message.getEstimatedFrame(with: font)
        messageTextView.snp.makeConstraints {
            $0.width.equalTo(estimatedFrame.width + 22)
        }
        
        switch model.chatType {
        case .receive:
            messageTextView.backgroundColor = .white
            messageTextView.snp.makeConstraints {
                $0.leading.equalToSuperview().inset(23)
            }
            timeLabel.snp.makeConstraints {
                $0.leading.equalTo(messageTextView.snp.trailing).offset(6)
            }
        case .send:
            messageTextView.backgroundColor = Color.light_Green
            messageTextView.snp.makeConstraints {
                $0.trailing.equalToSuperview().inset(23)
            }
            timeLabel.snp.makeConstraints {
                $0.trailing.equalTo(messageTextView.snp.leading).offset(-6)
            }
        }
    }
}
