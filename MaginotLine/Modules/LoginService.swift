//
//  LoginService.swift
//  MaginotLine
//
//  Created by Eunchan Kim on 2022/11/29.
//

import Foundation

final class LoginService: NSObject {
    
    static let shared = LoginService()
    var id: String?
    var nick: String?
    
    override init() {
        super.init()
    }
    
    //아이디 가져오기
    func getID() -> String? {
        id = UserDefaults.standard.string(forKey: Constant.loginID)
        return id
    }
    //유저 닉네임 저장
    func useNick(nick: String){
        UserDefaults.standard.set(nick, forKey: Constant.loginNick)
    }
    
    
    //로그인 확인
    func checkLogin() -> Bool {
        if UserDefaults.standard.string(forKey: Constant.loginID) != nil {
            return true
        } else {
            return false
        }
    }
    //로그인 아이디 저장
    func login(id: String) {
        UserDefaults.standard.set(id, forKey: Constant.loginID)
    }
    //로그아웃
    func logout() {
        UserDefaults.standard.removeObject(forKey: Constant.loginID)
        UserDefaults.standard.removeObject(forKey: Constant.loginNick)
    }
}
