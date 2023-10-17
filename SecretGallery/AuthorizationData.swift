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
}
