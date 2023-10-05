//
//  WriteViewController.swift
//  WishToGraduate
//
//  Created by KJ on 2023/06/17.
//

import UIKit

import SnapKit
import Then
import Photos
import PhotosUI

final class WriteViewController: UIViewController {
    
    // MARK: - Properties
    private let contentsTextViewPlaceholer = "내용을 작성해주세요."
    private var borrowTypeCollectionViewDelegate: BorrowTypeCollectionViewDelegate?
    private var categoryCollectionViewDelegate: CategoryCollectionViewDelegate?
    var isBorrow: Bool = true
    var category = "기타"
    private var date = ""
    
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
    
    public var hasPhoto: Bool = false {
        didSet {
            [photoImageIcon, photoLabel].forEach {
                $0.isHidden = hasPhoto
            }
        }
    }
    
    public var photoImage: UIImage? = nil {
        didSet {
            photoImageView.image = photoImage
        }
    }
    private let photoImageView = UIImageView()
    private let photoImageIcon = UIImageView()
    private let photoLabel = UILabel()
    
    private let titleLabel = UILabel()
    private let titleTextField = UITextField()
    
    private let borrowLabel = UILabel()
    private lazy var borrowTypeCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    private let categoryLabel = UILabel()
    private lazy var categoryCollectionView: CategoryCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        return CategoryCollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
    private let contentsLabel = UILabel()
    private let contentsTextView = UITextView()
    
    private let deadLineLabel = UILabel()
    private let deadLineTextField = UITextField()
    private let deadLineDatePicker = UIDatePicker()
    
    private let bottomView = UIView()
    private let bottomLine = UIView()
    private let writeButton = UIButton(type: .system)
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setToolBar()
        setLayout()
        setRegister()
        setDelegate()
        setButton()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    deinit {
        borrowTypeCollectionViewDelegate = nil
        categoryCollectionViewDelegate = nil
        NotificationCenter.default.removeObserver(self)
    }
}

private extension WriteViewController {
    func setUI() {
        view.backgroundColor = Color.light_Green
        
        photoImageView.do {
            $0.backgroundColor = UIColor(red: 233/255, green: 234/255, blue: 237/255, alpha: 1.0)
            $0.layer.cornerRadius = 10
            $0.clipsToBounds = true
            $0.isUserInteractionEnabled = true
        }
        
        photoImageIcon.do {
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
        
        deadLineTextField.do {
            $0.placeholder = "게시글을 유지할 기간을 선택해주세요."
            $0.setPlaceholderColor(placeholderColor: Color.placeholder_Grey)
            $0.font = .fontGuide(.placeholder)
            $0.layer.cornerRadius = 5
            $0.layer.borderColor = Color.circle_Grey.cgColor
            $0.layer.borderWidth = 1
            $0.setLeftPaddingPoints(11)
            $0.inputView = deadLineDatePicker
            $0.delegate = self
        }
        
        deadLineDatePicker.do {
            $0.datePickerMode = .date
            $0.preferredDatePickerStyle = .wheels
            $0.locale = Locale(identifier: "ko-KR")
        }
        
        bottomView.backgroundColor = .white
        bottomLine.backgroundColor = Color.line_Grey
        writeButton.do {
            $0.setTitle("글 작성하기", for: .normal)
            $0.backgroundColor = Color.main2_Green
            $0.setTitleColor(.white, for: .normal)
            $0.titleLabel?.font = .fontGuide(.title_bold)
            $0.layer.cornerRadius = 10
        }
    }
    
    func setLayout() {
        view.addSubviews(navigationView, scrollView, bottomView)
        scrollView.addSubviews(
            photoImageView, photoImageIcon, photoLabel, titleLabel, titleTextField, borrowLabel, borrowTypeCollectionView, categoryLabel, categoryCollectionView, contentsLabel, contentsTextView, deadLineLabel, deadLineTextField)
        bottomView.addSubviews(bottomLine, writeButton)
        
        navigationView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(52)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(navigationView.snp.bottom)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(88)
        }
        
        bottomView.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(81)
        }
        
        bottomLine.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        writeButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15)
            $0.leading.trailing.equalToSuperview().inset(22)
            $0.height.equalTo(45)
        }
        
        photoImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.leading.equalToSuperview().inset(23)
            $0.size.equalTo(110)
        }
        
        photoImageIcon.snp.makeConstraints {
            $0.top.equalTo(photoImageView).inset(35)
            $0.centerX.equalTo(photoImageView.snp.centerX)
        }
        
        photoLabel.snp.makeConstraints {
            $0.top.equalTo(photoImageIcon.snp.bottom).offset(3)
            $0.centerX.equalTo(photoImageView.snp.centerX)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(photoImageView.snp.bottom).offset(20)
            $0.leading.equalTo(photoImageView)
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
        
        borrowTypeCollectionView.snp.makeConstraints {
            $0.top.equalTo(borrowLabel.snp.bottom).offset(10)
            $0.height.equalTo(30)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        categoryLabel.snp.makeConstraints {
            $0.top.equalTo(borrowTypeCollectionView.snp.bottom).offset(22)
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
        }
        
        deadLineTextField.snp.makeConstraints {
            $0.top.equalTo(deadLineLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(23)
            $0.bottom.equalToSuperview().inset(50)
            $0.height.equalTo(43)
        }
    }
    
    func setDelegate() {
        borrowTypeCollectionViewDelegate = BorrowTypeCollectionViewDelegate()
        borrowTypeCollectionViewDelegate?.writeViewController = self
        categoryCollectionViewDelegate = CategoryCollectionViewDelegate()
        borrowTypeCollectionView.delegate = borrowTypeCollectionViewDelegate
        borrowTypeCollectionView.dataSource = borrowTypeCollectionViewDelegate
        categoryCollectionView.delegate = categoryCollectionViewDelegate
    }
    
    func setRegister() {
        borrowTypeCollectionView.registerCell(BorrowTypeCollectionViewCell.self)
    }
    
    func setButton() {
        navigationView.closeButtonHandler = {[weak self] in
            self?.dismiss(animated: true)
        }
        deadLineDatePicker.addTarget(self, action: #selector(dateChange), for: .valueChanged)
        photoImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(addPhotoButtonDidTap)))
        writeButton.addTarget(self, action: #selector(writeButtonDidTap), for: .touchUpInside)
    }
    
    func dateFormat(date: Date) -> String {
        let selectFormatter = DateFormatter()
        selectFormatter.dateFormat = "yyyy.MM.dd"
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = " HH:mm a"
        
        // Date를 ISO 8601 형식의 문자열로 변환
        let isoDateFormatter = ISO8601DateFormatter()
        isoDateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        self.date = isoDateFormatter.string(from: date)
        
        return selectFormatter.string(from: date).appending(timeFormatter.string(from: Date()))
    }
    
    func setToolBar() {
        let toolBar = UIToolbar()
        
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonHandeler))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonHandeler))
        
        toolBar.items = [cancelButton, flexibleSpace, doneButton]
        toolBar.sizeToFit()
        
        deadLineTextField.inputAccessoryView = toolBar
    }
    
    func openPHPicker() {
        var config = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
        config.filter = .images
        config.selectionLimit = 1
        let controller = PHPickerViewController(configuration: config)
        
        controller.delegate = self
        self.present(controller, animated: true, completion: nil)
    }
    
    @objc
    func dateChange(_ sender: UIDatePicker) {
        deadLineTextField.text = dateFormat(date: sender.date)
    }
    
    @objc
    func doneButtonHandeler(_ sender: UIBarButtonItem) {
        deadLineTextField.text = dateFormat(date: deadLineDatePicker.date)
        deadLineTextField.resignFirstResponder()
    }
    
    @objc
    func cancelButtonHandeler(_ sender: UIBarButtonItem) {
        deadLineTextField.text = nil
        deadLineTextField.resignFirstResponder()
    }
    
    @objc
    func keyboardWillShow(_ notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
            scrollView.contentInset = contentInsets
            scrollView.scrollIndicatorInsets = contentInsets
            scrollView.setContentOffset(CGPoint(x: 0, y: keyboardSize.height), animated: true)
        }
    }
    
    @objc
    func keyboardWillHide(_ notification: Notification) {
        let contentInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc
    func addPhotoButtonDidTap() {
        openPHPicker()
    }
    
    @objc
    func writeButtonDidTap() {
        createPost(borrow: self.isBorrow, category: self.category, content: contentsTextView.text, duedate: self.date, photoUrl: "", title: titleTextField.text ?? "")
        self.dismiss(animated: true)
    }
}

extension WriteViewController {
    
    func createPost(borrow: Bool, category: String, content: String, duedate: String, photoUrl: String, title: String) {
        PostAPI.shared.createPost(borrow: borrow, category: category, content: content, duedate: duedate, photoUrl: photoUrl, title: title) { [weak self] result in
            guard self != nil else { return }
            guard (result?.data) != nil else { return }
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

extension WriteViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        guard !results.isEmpty else {
            return
        }
        
        let imageResult = results[0]
        
        if let assetId = imageResult.assetIdentifier {
            DispatchQueue.main.async { [weak self] in
                self?.hasPhoto = true
            }
        }
        if imageResult.itemProvider.canLoadObject(ofClass: UIImage.self) {
            imageResult.itemProvider.loadObject(ofClass: UIImage.self) { (selectedImage, error) in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    DispatchQueue.main.async { [weak self] in
                        self?.photoImageView.image = selectedImage as? UIImage
                    }
                }
            }
        }
    }
    
    
}
