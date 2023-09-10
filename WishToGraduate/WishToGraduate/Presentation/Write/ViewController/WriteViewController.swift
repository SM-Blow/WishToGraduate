//
//  WriteViewController.swift
//  WishToGraduate
//
//  Created by KJ on 2023/06/17.
//

import UIKit

import SnapKit
import Then

final class WriteViewController: UIViewController {
    
    // MARK: - Properties
    private let contentsTextViewPlaceholer = "내용을 작성해주세요."
    
    // MARK: - UI Components
    private let navigationView = WriteNavigationView()
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.isScrollEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = true
        return scrollView
    }()
    
    private let photoView = UIView()
    private let photoImage = UIImageView()
    private let photoLabel = UILabel()
    
    private let titleLabel = UILabel()
    private let titleTextField = UITextField()
    
    private let borrowLabel = UILabel()
    //    private let collectionView = UICollectionView()
    
    private let categoryLabel = UILabel()
    private lazy var categoryCollectionView: CategoryCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        return CategoryCollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
    private let contentsLabel = UILabel()
    private let contentsTextView = UITextView()
    
    private let deadLineLabel = UILabel()
    private let deadLineView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
    }
    
}

private extension WriteViewController {
    func setUI() {
        view.backgroundColor = Color.light_Green
        
        photoView.do {
            $0.backgroundColor = UIColor(red: 233/255, green: 234/255, blue: 237/255, alpha: 1.0)
            $0.layer.cornerRadius = 10
            $0.clipsToBounds = true
        }
        
        photoImage.do {
            $0.image = Image.cameraIcon
        }
        
        photoLabel.do {
            $0.text = "사진"
            $0.font = .fontGuide(.h2_bold)
            $0.textColor = UIColor(red: 106/255, green: 111/255, blue: 122/255, alpha: 1.0)
        }
        
        titleLabel.text = "제목 *"
        borrowLabel.text = "빌리기/빌려주기 *"
        categoryLabel.text = "카테고리 *"
        contentsLabel.text = "내용 *"
        deadLineLabel.text = "기한 *"
        
        [titleLabel, borrowLabel, categoryLabel, contentsLabel, deadLineLabel].forEach{
            $0.font = .fontGuide(.title)
        }
        
        titleTextField.do {
            $0.placeholder = "제목을 작성해주세요."
            $0.setPlaceholderColor(placeholderColor: Color.placeholder_Grey)
            $0.font = .fontGuide(.placeholder)
            $0.layer.cornerRadius = 5
            $0.layer.borderColor = Color.circle_Grey.cgColor
            $0.layer.borderWidth = 1
            $0.setLeftPaddingPoints(11)
            $0.delegate = self
        }
        
        contentsTextView.do {
            $0.text = contentsTextViewPlaceholer
            $0.textColor = Color.placeholder_Grey
            $0.font = .fontGuide(.placeholder)
            $0.layer.cornerRadius = 5
            $0.layer.borderWidth = 1
            $0.layer.borderColor = Color.circle_Grey.cgColor
            $0.delegate = self
            $0.contentInset = UIEdgeInsets(top: 0, left: 11, bottom: 0, right: 11)
        }
        
        borrowLabel.do {
            $0.font = .fontGuide(.title)
        }
    }
    
    func setLayout() {
        view.addSubviews(navigationView, scrollView)
        scrollView.addSubviews(
            photoView, titleLabel, titleTextField, borrowLabel, categoryLabel, categoryCollectionView, contentsLabel, contentsTextView, deadLineLabel)
        
        navigationView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(52)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(navigationView.snp.bottom)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        photoView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.leading.equalToSuperview().inset(23)
            $0.size.equalTo(110)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(photoView.snp.bottom).offset(20)
            $0.leading.equalTo(photoView)
        }
        
        titleTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().inset(23)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(23)
            $0.height.equalTo(43)
        }
        
        borrowLabel.snp.makeConstraints {
            $0.top.equalTo(titleTextField.snp.bottom).offset(22)
            $0.leading.equalTo(titleTextField.snp.leading)
        }
        
        /// borrowLabel 수정하기
        categoryLabel.snp.makeConstraints {
            $0.top.equalTo(borrowLabel.snp.bottom).offset(22)
            $0.leading.equalTo(borrowLabel.snp.leading)
        }
        
        categoryCollectionView.snp.makeConstraints {
            $0.top.equalTo(categoryLabel.snp.bottom).offset(17)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(65)
        }
        
        contentsLabel.snp.makeConstraints {
            $0.top.equalTo(categoryCollectionView.snp.bottom).offset(19)
            $0.leading.equalTo(borrowLabel.snp.leading)
        }
        
        contentsTextView.snp.makeConstraints {
            $0.top.equalTo(contentsLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(23)
            $0.height.equalTo(122)
        }
        
        deadLineLabel.snp.makeConstraints {
            $0.top.equalTo(contentsTextView.snp.bottom).offset(22)
            $0.leading.equalTo(contentsTextView.snp.leading)
            $0.bottom.equalToSuperview().inset(50)
        }
    }
}

extension WriteViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = nil
        textView.textColor = .black
        textView.layer.borderColor = Color.main_Green.cgColor
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = contentsTextViewPlaceholer
            textView.textColor = Color.placeholder_Grey
            textView.layer.borderColor = Color.line_Grey.cgColor
//            updateCountLabel(characterCount: 0)
        }
    }
}

extension WriteViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = Color.main_Green.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if ((textField.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty) != nil) {
            textField.layer.borderColor = Color.line_Grey.cgColor
        }
    }
}
