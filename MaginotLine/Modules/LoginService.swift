//
//  LoginService.swift
//  MaginotLine
//
//  Created by Eunchan Kim on 2022/11/29.
//

import Foundation

final class LoginService: NSObject {
    
    static let shared = LoginService()
    
    override init() {
        super.init()
        
    }
    
    func checkLogin() -> Bool {
        if UserDefaults.standard.string(forKey: Constant.loginID) != nil {
            return true
        } else {
            return false
        }
    }
    
    func login(id: String) {
        UserDefaults.standard.set(id, forKey: Constant.loginID)
    }
    
    func logout() {
        UserDefaults.standard.removeObject(forKey: Constant.loginID)
    }
}
