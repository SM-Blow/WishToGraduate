//
//  SearchViewController.swift
//  WishToGraduate
//
//  Created by KJ on 2023/06/26.
//

import UIKit

import Then
import SnapKit

class SearchViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let closeImageView = UIImageView()
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        setNavigationBar()
    }
}

extension SearchViewController {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        
        view.backgroundColor = Color.light_Green
        
        closeImageView.do {
            $0.image = Image.closeButton
        }
        
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
    }
    
    // MARK: - Methods
    
    private func setNavigationBar() {
        navigationController?.navigationBar.backgroundColor = Color.light_Green
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: Color.main_Green,
            .font: UIFont.fontGuide(.h1)
        ]
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: closeImageView)
        navigationItem.title = "검색하기"
    }
}
