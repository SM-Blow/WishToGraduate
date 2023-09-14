//
//  UIAlertController+.swift
//  WishToGraduate
//
//  Created by KJ on 2023/09/15.
//

import UIKit

extension UIAlertController {
    // 경고 창을 표시하는 함수
    static func showAlert(title: String?, message: String?, preferredStyle: UIAlertController.Style = .alert, completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        let okAction = UIAlertAction(title: "확인", style: .default) { _ in
            completion?()
        }
        alertController.addAction(okAction)
        
        if let topViewController = UIApplication.shared.keyWindow?.rootViewController {
            topViewController.present(alertController, animated: true, completion: nil)
        }
    }
}
