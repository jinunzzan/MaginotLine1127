//
//  Api.swift
//  MaginotLine
//
//  Created by Eunchan Kim on 2022/11/28.
//

import Foundation
import Alamofire


let url = "https://maginotionline.azurewebsites.net"
let joinUrl = url + "/member_info"

let postUrl = url + "/board_post"




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

var loginSuccess = "" //로그인시 로그인 정보 담는 변수
var loginSuccessId:String? // 로그인시 로그인 아이디 담는 변수

var loginMemberInfo: MemberInfo?

// 커뮤니티
struct BoardPost:Codable{
    var board_num: Int?
    var post_content: String
    var member_nick: String
    var post_date: String
    //    var post_update: Int
    var post_num: Int
}

//커뮤니티 댓글
struct PostComment:Codable{
    var comment_num: Int?
    var post_num:Int?
    var member_nick:String?
    var comment_content:String?
}



// 변수 사용하기 위해 전역변수에도 생성
let id = UserDefaults.standard.string(forKey: "loginSuccessId")


