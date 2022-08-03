//
//  TextFieldTemplate.swift
//  RapptrIOS
//
//  Created by Gregory Aboyeji on 8/1/22.
//

import UIKit

class TextFieldTemplate: UITextField {

    var padding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 5)

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}

//MARK: UITextFieldDelegate
extension TextFieldTemplate: UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("begin...")
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
     
        let textEntered: NSString = (textField.text ?? "") as NSString
        let text = textEntered.replacingCharacters(in: range, with: string)
        
        if text.count > 0 {
            
        } else {
            
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //let textEntered: NSString = (textField.text ?? "") as NSString
        let text = textField.text
        
        if text!.count > 0 {
            print("text: \(text!)")
        }
        
        return true
    }
}

