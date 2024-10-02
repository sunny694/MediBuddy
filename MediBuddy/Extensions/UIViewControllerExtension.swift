//
//  UIViewControllerExtension.swift
//  MediBuddy
//
//  Created by Sunny Jha on 30/09/24.
//

import Foundation
import UIKit

extension UIViewController {
    @objc func keyboardWillShow(sender: NSNotification) {
        guard let userInfo = sender.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let currentTextField = UIResponder.currentFirst() as? UITextField else {
            return
        }
        
        // check if the top of the keyboard is above the bottom of the currently focused textbox
        let keyboardTopY = keyboardFrame.cgRectValue.origin.y
        let convertedTextFieldFrame = view.convert(currentTextField.frame, from: currentTextField.superview)

        let textFieldBottomY = convertedTextFieldFrame.origin.y + convertedTextFieldFrame.size.height
        
        // if textField bottom is below keyboard bottom - bump the frame up
        if textFieldBottomY > keyboardTopY {
            let textBoxY = convertedTextFieldFrame.origin.y
            let newFrameY = (textBoxY - keyboardTopY / 2) * -1
            view.frame.origin.y = newFrameY
        }
    }
    
    @objc func keyboardWillHide(sender: NSNotification) {
        view.frame.origin.y = 0
    }
    
    func showAlert(title: String = "", message: String,isRootLevel:Bool = false) {
        DispatchQueue.main.async(execute: {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            if isRootLevel {
                UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
            } else {
                self.present(alert, animated: true, completion: nil)
            }
        })
    }
    
    func removePreviousVC() {
            // Check if the navigation controller exists
            guard let navigationController = self.navigationController else { return }

            // Get the current view controller stack
            var viewControllers = navigationController.viewControllers

            // Check if there is more than one view controller in the stack
            if viewControllers.count >= 2 {
                // Remove the second last view controller (which is the previous one)
                viewControllers.remove(at: viewControllers.count - 2)

                // Update the navigation stack
                navigationController.viewControllers = viewControllers
            }
        }
    
}
