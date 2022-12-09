//
//  MemberJoinViewController.swift
//  MaginotLine
//
//  Created by 권지민 on 2022/11/25.
//

import UIKit
import Alamofire

class MemberJoinViewController: UIViewController {
    
    
    
    @IBOutlet weak var tfUserName: UITextField!
    @IBOutlet weak var tfUserId: UITextField!
    @IBOutlet weak var tfUserPw: UITextField!
    @IBOutlet weak var tfUserPwCheck: UITextField!
    @IBOutlet weak var tfUserNick: UITextField!
    
    @IBOutlet weak var btnSameIdCheck: UIButton!
    
    @IBOutlet weak var lblPw: UILabel!
    @IBOutlet weak var lblIdCheck: UILabel!
    @IBOutlet weak var lblPwCheck: UILabel!
    @IBOutlet weak var lblNickCheck: UILabel!
    
    @IBOutlet var defaultHiddenCollection: [UILabel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for label in defaultHiddenCollection {
            label.isHidden = true
            label.textColor = .red
        }
       
    }
    
    @IBAction func cancleBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func joinBtn(_ sender: Any) {
        join()
        // 회원가입 성공시 화면은 로그인 화면으로 이동한다.
        
        
    }
    
    
    @IBAction func nameTextFieldTyped(_ sender: UITextField) {
        //입력버튼 누르면 다음 tf 로 넘어가기
        if tfUserName.isFirstResponder{
            tfUserId.becomeFirstResponder()
        }
    }
    
    

 //아이디 조건
    @IBAction func idTextFieldTyped(_ sender: UITextField) {
        lblIdCheck.isHidden = false
         
         let userWord = tfUserId.text?.lowercased()
         tfUserId.text = userWord
         
         let minCount = 5
         let maxCount = 12
         let count = userWord!.count

         switch count {
         case 0:
             lblIdCheck.text = "아이디는 필수입력 정보입니다."
         case 1..<minCount:
             lblIdCheck.text = "아이디는 5글자 이상이어야 합니다."
         case minCount...maxCount:
             let idPattern = "^[a-z0-9-_]{\(minCount),\(maxCount)}$"
             let isVaildPattern = (userWord!.range(of: idPattern, options: .regularExpression) != nil)
             if isVaildPattern {
                 lblIdCheck.text = "조건에 맞는 아이디"
                 lblIdCheck.isHidden = true
                
             } else {
                 lblIdCheck.text = "소문자, 숫자, 빼기(-), 밑줄(_)만 사용할 수 있습니다."
             }
         default:
             lblIdCheck.text = "아이디는 12글자 이하이어야 합니다."
             //입력버튼 누르면 다음 tf로 넘어가기
             if tfUserId.isFirstResponder{
                 tfUserPw.becomeFirstResponder()
             }
         }
       
    }
    //비밀번호 조건
    
    @IBAction func passwordTextFieldTyped(_ sender: UITextField) {
        lblPw.isHidden = false
        
        let minCount = 8
        let maxCount = 16
        let count = tfUserPw.text!.count

        switch count {
        case 0:
            lblPw.text = "비밀번호는 필수입력 정보입니다."
            
        case 1..<minCount:
            lblPw.text = "비밀번호는 8글자 이상이어야 합니다."
        case minCount...maxCount:
            let idPattern = #"^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{\#(minCount),\#(maxCount)}$"#
            let isVaildPattern = (tfUserPw.text!.range(of: idPattern, options: .regularExpression) != nil)
            if isVaildPattern {
                lblPw.text = "조건에 맞는 비밀번호"
                lblPw.isHidden = true
                
            } else {
                lblPw.text = "영어알파벳, 숫자, 특수문자가 필수로 입력되어야 합니다."
            }
        default:
            lblPw.text = "비밀번호는 16글자 이하이어야 합니다."
            //입력버튼 누르면 다음 tf로 넘어가기
            if tfUserPw.isFirstResponder{
                tfUserPwCheck.becomeFirstResponder()
            }
        }
       
    }
    
    
    @IBAction func passwordCheckTextFieldTyped(_ sender: UITextField) {
        lblPwCheck.isHidden = false
        var checkPw = tfUserPwCheck.text
        if checkPw == tfUserPw.text {
            lblPwCheck.text = ""
        }else {
            lblPwCheck.text = "비밀번호가 일치하지 않습니다."
            lblPwCheck.textColor = .red
        }
        if tfUserPwCheck.isFirstResponder{
            tfUserNick.becomeFirstResponder()
        }
    }
    
    func joinMessage(){
        let alert = UIAlertController(title: "회원가입 완료", message: "회원가입을 축하드립니다!\n함께 지각러를 탈출해보아요.", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default){(_) in
            //
            /////
            //            let sb = UIStoryboard(name: "Main", bundle: nil)
            //            let vc = sb.instantiateViewController(withIdentifier: "LoginModalViewController") as! LoginModalViewController
            //
            //            self.present(vc, animated: true, completion: nil)
            self.dismiss(animated: true)
        }
        alert.addAction(okAction)
        
        
        present(alert, animated: true)
    }
    
}
extension MemberJoinViewController {
    func join(){
        guard let userName = tfUserName.text, !userName.isEmpty else { return }
        guard let userId = tfUserId.text, !userId.isEmpty else { return }
        guard let userPw = tfUserPw.text, !userPw.isEmpty else { return }
        guard let userNick = tfUserNick.text, !userNick.isEmpty else { return }
        let params: Parameters = [
            "member_id" : userId,
            "member_pw" : userPw,
            "member_name": userName,
            "member_nick" : userNick
        ]
        
        AF.request(
            joinUrl,
            method: .post,
            parameters: params,
            encoding: JSONEncoding.default)
        .responseData { response in
            switch response.result {
            case .success(let res):
                do {
                    print("데이터", String(data:res, encoding: .utf8) ?? "")
                    self.tfUserId.text = ""
                    self.tfUserPw.text = ""
                    self.tfUserName.text = ""
                    self.tfUserNick.text = ""
                    self.tfUserPwCheck.text = ""
                    
                    self.joinMessage()
                    
                }
            case .failure(let err):
                print("응답 코드 :", response.response?.statusCode ?? 0)
                print("에러 ::", err.localizedDescription)
                break
            }
        }
        
    }
    
}
