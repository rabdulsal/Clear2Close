//
//  UITextField+Clear2Close.swift
//  Clear2Close
//
//  Created by Rashad Abdul-Salam on 1/29/19.
//  Copyright © 2019 Clear2Close. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        self.addCancelButton()
    }
    
    func addCancelButton() {
        let keyBoardToolbar = UIToolbar()
        keyBoardToolbar.sizeToFit()
        keyBoardToolbar.backgroundColor = UIColor.lightGray
        
        let flexibleSpaceBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelBarButton = UIBarButtonItem(title: "X", style: .plain, target: self, action: #selector(UITextField.cancel))
        let cancelButtonAttrs: [NSAttributedString.Key: Any] = [
//            NSAttributedString.Key.font : UIFont.helvetica(size: 18),
            NSAttributedString.Key.foregroundColor: UIColor.red
        ]
        cancelBarButton.setTitleTextAttributes(cancelButtonAttrs, for: UIControl.State.normal)
        cancelBarButton.setTitleTextAttributes(cancelButtonAttrs, for: UIControl.State.highlighted)
        keyBoardToolbar.items = [flexibleSpaceBarButton, cancelBarButton]
        inputAccessoryView = keyBoardToolbar
    }
    
//    func toggleAlertAction(action: UIAlertAction) {
//        if let text = self.text, text.isBlankSpaceTrimmed {
//            action.isEnabled = true
//        } else {
//            action.isEnabled = false
//        }
//    }
    
    func removeDoneButton() {
        inputAccessoryView = nil
    }
    
    @objc func cancel() {
        resignFirstResponder()
    }
}
