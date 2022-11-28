//
//  Api.swift
//  MaginotLine
//
//  Created by Eunchan Kim on 2022/11/28.
//

import Foundation
import Alamofire


let url = "http://localhost:3000"
let joinUrl = url + "/member_info"



enum NetworkResult<T> {
    case success(T)
    case requestErr(T)
    case pathErr
    case serverErr
    case networkFail
}

struct MemberInfo: Codable {
    let member_num: Int
    let member_id: String
    let member_name: String
    let member_pw: String
    let member_nick: String
}

var loginSuccess:String = "" // 로그인시 로그인 아이디 담는 변수
