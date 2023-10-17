//
//  LogInViewController.swift
//  SecretGallery
//
//  Created by Admin on 17.10.23.
//

import UIKit

class LogInViewController: UIViewController {
    
    @IBOutlet weak var pinTextField: UITextField!
    
    @IBOutlet var pinCircles: [UIView]!
    
    @IBOutlet weak var pinView: UIView!
    
    @IBOutlet weak var hiddenPinTextField: UITextField!
    
    @IBOutlet weak var labelWelcome: UILabel!
    
    private let circleSize = 40.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        hideKeyboardWhenTappedAround()
    }

    private func setUp() {
        
        labelWelcome.text = labelWelcome.text ?? "" + "Guest!"
        
        for circle in pinCircles {
            circle.backgroundColor = .clear
            circle.layer.borderColor = UIColor.systemPurple.cgColor
            circle.layer.borderWidth = 3
            circle.layer.cornerRadius = circleSize / 2
        }
        
        pinView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(pinTap)))
        pinView.isUserInteractionEnabled = true
        
        hiddenPinTextField.delegate = self
    }
    
    @objc private func pinTap() {
        hiddenPinTextField.becomeFirstResponder()
    }
    
}

extension LogInViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        if textField.text?.count ?? 0 > 4 { pinTextField.text?.removeLast() }
        if (pinTextField.text ?? "").contains(".") { pinTextField.text?.removeAll(where: { $0 == "."}) }
        let text = textField.text ?? ""
        
        for i in 0..<text.count { pinCircles[i].backgroundColor = .systemPurple }
        for i in text.count..<pinCircles.count { pinCircles[i].backgroundColor = .clear }
        
    }
}
