//
//  EventCollectionViewCell.swift
//  WishToGraduate
//
//  Created by 강윤서 on 2023/09/21.
//

import UIKit

import SnapKit
import Then

final class EventCollectionViewCell: UICollectionViewCell {
    
    private let eventTitleLabel = UILabel()
    private let majorLabel = UILabel()
    private let DateLabel = UILabel()
    private let timeoutLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension EventCollectionViewCell {
    private func setUI() {
        backgroundColor = .white
        layer.cornerRadius = 10
        clipsToBounds = true
        layer.shadowColor = Color.btn_darkGrey.cgColor
        layer.shadowOpacity = 0.12
        layer.shadowRadius = 8
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.masksToBounds = false
        
        eventTitleLabel.font = .fontGuide(.m1)
        
        [majorLabel, timeoutLabel].forEach {
            $0.font = .fontGuide(.date1)
            $0.textColor = Color.date_Grey
        }
        
        DateLabel.do {
            $0.font = .fontGuide(.date1)
            $0.textColor = Color.main2_Green
            $0.text = "Date"
        }
    }
    
    private func setLayout() {
        contentView.addSubviews(eventTitleLabel, majorLabel, DateLabel, timeoutLabel)
        
        eventTitleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(15)
        }
        
        majorLabel.snp.makeConstraints {
            $0.top.equalTo(eventTitleLabel.snp.bottom).offset(6)
            $0.leading.equalToSuperview().inset(15)
        }
        
        timeoutLabel.snp.makeConstraints {
            $0.trailing.bottom.equalToSuperview().inset(15)
        }
        
        DateLabel.snp.makeConstraints {
            $0.trailing.equalTo(timeoutLabel.snp.leading).offset(-7)
            $0.bottom.equalToSuperview().inset(15)
        }

    }
    
    func setData(_ model: EventListResponseDto) {
        eventTitleLabel.text = model.title
        majorLabel.text = model.host
        timeoutLabel.text = "\(model.dueDate[0]).\(model.dueDate[1]).\(model.dueDate[2])"
    }
}
