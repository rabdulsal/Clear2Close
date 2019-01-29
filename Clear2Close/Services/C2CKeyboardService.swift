//
//  C2CKeyboardService.swift
//  Clear2Close
//
//  Created by Rashad Abdul-Salam on 1/29/19.
//  Copyright © 2019 Clear2Close. All rights reserved.
//

import Foundation
import UIKit

class C2CKeyboardService: NSObject {
    
    weak fileprivate var scrollView:UIScrollView?
    
    init(_ scrollView:UIScrollView) {
        self.scrollView = scrollView
    }
    
    func beginObservingKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(C2CKeyboardService.keyboardDidHide(_:)), name: UIResponder.keyboardDidHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(C2CKeyboardService.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    func endObservingKeyboard() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notif:Notification) {
        if let keyboardFrame = (notif.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue {
            let contentInsets = UIEdgeInsets(top: scrollView!.contentInset.top, left: 0, bottom: keyboardFrame.height, right: 0)
            scrollView!.contentInset = contentInsets
            scrollView!.scrollIndicatorInsets = contentInsets
        }
    }
    
    @objc func keyboardDidHide(_ notif:Notification) {
        let contentInset = UIEdgeInsets(top: scrollView!.contentInset.top, left: 0, bottom: 0, right: 0)
        scrollView!.contentInset = contentInset
        scrollView!.scrollIndicatorInsets = contentInset
    }
    
}
