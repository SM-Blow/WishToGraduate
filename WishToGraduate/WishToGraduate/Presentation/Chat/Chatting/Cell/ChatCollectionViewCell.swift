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
    
    private var cellType: ChatType?
    
    // MARK: - View Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
        setEstimatedFrame()
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
            $0.backgroundColor = .black
            $0.layer.cornerRadius = 10
            $0.clipsToBounds = true
            $0.textAlignment = .natural
            $0.isEditable = false
            $0.makeShadow(radius: 8, offset: CGSize(width: 0, height: 0), opacity: 0.12)
        }
        
        timeLabel.do {
            $0.font = .fontGuide(.date1)
            $0.textColor = Color.placeholder_Grey
            $0.text = "11:45"
        }
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
        addSubviews(messageTextView, timeLabel)
        
        messageTextView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
        }
        
        timeLabel.snp.makeConstraints {
            $0.bottom.equalTo(messageTextView.snp.bottom)
        }
    }
    
    // MARK: - Methods
    
    func setEstimatedFrame() {
        if let text = messageTextView.text {
            guard let font = messageTextView.font else { return }
            let estimatedFrame = text.getEstimatedFrame(with: font)
            messageTextView.snp.makeConstraints {
                $0.width.equalTo(estimatedFrame.width + 22)
                $0.height.equalTo(estimatedFrame.height + 20)
            }
            switch cellType {
            case .receive:
            
                messageTextView.snp.makeConstraints {
                    $0.leading.equalToSuperview().inset(23)
                }
                timeLabel.snp.makeConstraints {
                    $0.leading.equalTo(messageTextView.snp.trailing).offset(6)
                    $0.bottom.equalTo(messageTextView.snp.bottom)
                }
                messageTextView.backgroundColor = .white
            case .send:
            
                messageTextView.snp.makeConstraints {
                    $0.trailing.equalToSuperview().inset(23)
                }
                timeLabel.snp.makeConstraints {
                    $0.trailing.equalTo(messageTextView.snp.leading).offset(-6)
                    $0.bottom.equalTo(messageTextView.snp.bottom)
                }
                messageTextView.backgroundColor = Color.light_Green
            case .none:
                return
            }
        }
    }
    
    func setDataBind(_ model: ChatModel) {
        messageTextView.text = model.message
        cellType = model.chatType
        
        guard let font = messageTextView.font else { return }
        let estimatedFrame = model.message.getEstimatedFrame(with: font)
        messageTextView.snp.remakeConstraints {
            $0.width.equalTo(estimatedFrame.width + 22)
        }
        switch cellType {
        case .receive:
            messageTextView.snp.remakeConstraints {
                $0.leading.equalToSuperview().inset(23)
            }
            timeLabel.snp.remakeConstraints {
                $0.leading.equalTo(messageTextView.snp.trailing).offset(6)
            }
            messageTextView.backgroundColor = .white
            
        case .send:
            messageTextView.snp.remakeConstraints {
                $0.trailing.equalToSuperview().inset(23)
            }
            timeLabel.snp.remakeConstraints {
                $0.trailing.equalTo(messageTextView.snp.leading).offset(-6)
            }
            
            messageTextView.backgroundColor = Color.light_Green
        case .none:
            return
        }
    }
}
