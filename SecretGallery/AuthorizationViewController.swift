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
        hideKeyboardWhenTappedAround()
        submitButton.addTarget(self, action: #selector(authorize), for: .touchUpInside)
    }

    @objc private func authorize() {
        let vc = LogInViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
}

extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
