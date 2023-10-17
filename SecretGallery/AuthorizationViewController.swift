//
//  AuthorizationViewController.swift
//  SecretGallery
//
//  Created by Admin on 17.10.23.
//

import UIKit

class AuthorizationViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var pinTextField: UITextField!
    
    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }

    private func setUp() {
        nameTextField.delegate = self
        pinTextField.delegate = self
        
        hideKeyboardWhenTappedAround()
        submitButton.addTarget(self, action: #selector(authorize), for: .touchUpInside)
    }
    
    @objc private func authorize() {
        AuthorizationData.isAuthorized = true
    }
    
}

extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension AuthorizationViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        if pinTextField.text?.count ?? 0 > 4 { pinTextField.text?.removeLast() }
        if nameTextField.text?.count ?? 0 > 10 { nameTextField.text?.removeLast() }
        if (pinTextField.text ?? "").contains(".") { pinTextField.text?.removeAll(where: { $0 == "."}) }
        let isNameTyped = !(nameTextField.text ?? "").isEmpty
        let isPinTyped = pinTextField.text?.count == 4
        
        guard !(isNameTyped && isPinTyped) else {
            submitButton.isHidden = false
            return
        }
        submitButton.isHidden = true
    }
}
