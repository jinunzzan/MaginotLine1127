//
//  Api.swift
//  MaginotLine
//
//  Created by Eunchan Kim on 2022/11/28.
//

import Foundation
import Alamofire


let url = "http://192.168.0.12:3000"
let joinUrl = url + "/member_info"



enum NetworkResult<T> {
    case success(T)
    case requestErr(T)
    case pathErr
    case serverErr
    case networkFail
}
// 회원가입, 로그인
struct MemberInfo: Codable {
    let member_num: Int
    let member_id: String
    let member_name: String
    let member_pw: String
    let member_nick: String
}

var loginSuccess:String = "" //로그인시 로그인 정보 담는 변수
var loginSuccessId:String? // 로그인시 로그인 아이디 담는 변수


// 커뮤니티
struct BoardPost:Codable{
    var board_num: Int
    var post_content: String
    var member_nick: String
    var post_date: String
    var post_update: Bool
    var post_num: Int
}

// 변수 사용하기 위해 전역변수에도 생성
let id = UserDefaults.standard.string(forKey: "loginSuccessId")


