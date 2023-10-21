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
    
    private let pin = AuthorizationData.userPin ?? "1111"
    
    private let circleSize = 40.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        hideKeyboardWhenTappedAround()
    }

    private func setUp() {
        labelWelcome.text = (labelWelcome.text ?? "") + (AuthorizationData.userName ?? "Guest")
        
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
    
    private func pinCorrect() {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "2")
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    private func pinIncorrect() {
        let animationDuration = 0.05
        for circle in pinCircles {
            UIView.animate(withDuration: animationDuration) {
                circle.frame.origin.x += 20
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
                UIView.animate(withDuration: animationDuration, delay: 0.0, options: [.curveEaseIn]) {
                    circle.frame.origin.x += 20
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2 * animationDuration) {
                UIView.animate(withDuration: animationDuration, delay: 0.0, options: [.curveEaseOut]) {
                    circle.frame.origin.x -= 20
                }
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3 * animationDuration) { [self] in
            for circle in pinCircles { circle.backgroundColor = .clear }
            pinTextField.text = ""
            pinTextField.resignFirstResponder()
        }
    }
    
}

extension LogInViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        if textField.text?.count ?? 0 > 4 { pinTextField.text?.removeLast() }
        if (pinTextField.text ?? "").contains(".") { pinTextField.text?.removeAll(where: { $0 == "."}) }
        let text = textField.text ?? ""
        
        for i in 0..<text.count { pinCircles[i].backgroundColor = .systemPurple }
        for i in text.count..<pinCircles.count { pinCircles[i].backgroundColor = .clear }
        
        guard text.count != 4 else {
            guard text != pin else {
                pinCorrect()
                return
            }
            pinIncorrect()
            return
        }
    }
}
