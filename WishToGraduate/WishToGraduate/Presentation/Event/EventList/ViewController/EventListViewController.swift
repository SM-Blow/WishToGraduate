//
//  EventListViewController.swift
//  WishToGraduate
//
//  Created by 강윤서 on 2023/09/21.
//

import UIKit

import SnapKit
import Then

final class EventListViewController: UIViewController {

    private var isCollectionViewLoaded = false
    
    // MARK: - UI Components
    private let navigationBar = CustomNavigationBar(title: "우리학교 행사")
    private lazy var eventListCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    private var eventList: [EventListResponseDto] = []
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        requestGetEventList()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        setDelegate()
        setRegister()
        setButton()
    }
}

extension EventListViewController {
    private func setUI() {
        view.backgroundColor = .white
        
        navigationBar.do {
            $0.isBackButtonIncluded = true
        }
    }
    
    private func setLayout() {
        view.addSubviews(navigationBar, eventListCollectionView)
        
        navigationBar.snp.makeConstraints {
            $0.top.directionalHorizontalEdges.equalToSuperview()
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 96 / 812)
        }
        
        eventListCollectionView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.directionalHorizontalEdges.bottom.equalToSuperview()
        }
    }
    
    private func setRegister() {
        eventListCollectionView.registerCell(AddCollectionViewCell.self)
        eventListCollectionView.registerCell(EventCollectionViewCell.self)
    }
    
    private func setDelegate() {
        eventListCollectionView.dataSource = self
        eventListCollectionView.delegate = self
    }
    
    private func backToHomeVC() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func setButton() {
        navigationBar.backButtonHandler = { [weak self] in
            self?.backToHomeVC()
        }
    }
}

extension EventListViewController {
    private func requestGetEventList() {
        EventAPI.shared.getEventList { [weak self] response in
            guard self != nil else { return }
            guard let data = response?.data else { return }
            self!.eventList = data
            self!.loadCollectionView()
        }
    }
    
    private func loadCollectionView() {
        isCollectionViewLoaded = true
    
        DispatchQueue.main.async { [weak self] in
            self?.eventListCollectionView.reloadData()
        }
    }
}

extension EventListViewController: UICollectionViewDelegateFlowLayout {
    
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
        switch indexPath.row {
        case eventList.count:
            let createEventViewController = CreateEventViewController()
            createEventViewController.modalTransitionStyle = .coverVertical
            createEventViewController.modalPresentationStyle = .overFullScreen
            self.present(createEventViewController, animated: true)
            createEventViewController.popHandler = { [weak self] in
                DispatchQueue.main.async { [weak self] in
                    self?.requestGetEventList()
                    self?.eventListCollectionView.reloadData()
                }
            }
        default:
            let eventDetailViewController = EventDetailViewController(eventId: eventList[indexPath.row].eventId)
            self.navigationController?.pushViewController(eventDetailViewController, animated: true)
        }
    }
}

extension EventListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return eventList.count + 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row != eventList.count {
            let cell = eventListCollectionView.dequeueCell(type: EventCollectionViewCell.self, indexPath: indexPath)
            cell.setData(eventList[indexPath.row])
            return cell
        } else {
            let cell = eventListCollectionView.dequeueCell(type: AddCollectionViewCell.self, indexPath: indexPath)
            cell.setText("행사 생성하기")
            return cell
        }
    }
}

