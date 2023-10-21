//
//  AuthorizationData.swift
//  SecretGallery
//
//  Created by Admin on 18.10.23.
//

import Foundation

class AuthorizationData {
    
    enum parameters: String {
        case isAuthorized
        case userName
        case userPin
    }
    
    static var isAuthorized: Bool? {
        
        get {
            return UserDefaults.standard.bool(forKey: parameters.isAuthorized.rawValue)
        }
        set {
            let defaults = UserDefaults.standard
            let key = parameters.isAuthorized.rawValue
            if let flag = newValue {
                defaults.setValue(flag, forKey: key)
            }
            else {
                defaults.removeObject(forKey: key)
            }
        }
    }
    
    static var userName: String? {
        
        get {
            return UserDefaults.standard.string(forKey: parameters.userName.rawValue)
        }
        set {
            let defaults = UserDefaults.standard
            let key = parameters.userName.rawValue
            if let name = newValue {
                defaults.setValue(name, forKey: key)
            }
            else {
                defaults.removeObject(forKey: key)
            }
        }
    }
    
    static var userPin: String? {
        
        get {
            return UserDefaults.standard.string(forKey: parameters.userPin.rawValue)
        }
        set {
            let defaults = UserDefaults.standard
            let key = parameters.userPin.rawValue
            if let userPin = newValue {
                defaults.setValue(userPin, forKey: key)
            }
            else {
                defaults.removeObject(forKey: key)
            }
        }
    }
}
