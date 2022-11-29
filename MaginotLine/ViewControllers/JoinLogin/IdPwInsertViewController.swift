//
//  IdPwInsertViewController.swift
//  MaginotLine
//
//  Created by Eunchan Kim on 2022/11/28.
//

import UIKit
import Alamofire

class IdPwInsertViewController: UIViewController {
    
    @IBOutlet weak var tfUserPw: UITextField!
    var memberInfo : MemberInfo?
    
    @IBOutlet weak var tfUserid: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let sheetPresentationController = sheetPresentationController {
            sheetPresentationController.detents = [.medium()]
        }
        
    }
    
    
    @IBAction func loginSubmitBtn(_ sender: Any) {
        login()
        self.dismiss(animated: true)
    }
    func login(){
        let loginUrl = url + "/member_login"
        guard let userId = tfUserid.text, !userId.isEmpty else { return }
        guard let userPw = tfUserPw.text, !userPw.isEmpty else { return }
        let params: Parameters = [
            "member_id" : userId,
            "member_pw" : userPw
        ]
        
        AF.request(
            loginUrl,
            method: .post, parameters: params,
            encoding: JSONEncoding.default)
        .responseData {
            response in
            switch response.result {
                case .success(let res):
                do {
                    print("데이터",String(data:res, encoding: .utf8) ?? "")
                    var loginData = String(data:res, encoding: .utf8)
                    loginSuccess.append(loginData ?? "")
                    print("loginSucess: \(loginSuccess)")
                
                    loginSuccessId = self.tfUserid.text ?? ""
                    print("loginSuccessId: \(loginSuccessId)")
                    // loginSuccessId userdefault에 담기
                    UserDefaults.standard.set(loginSuccessId, forKey: "loginSuccessId")
                    print("유저디폴트에 저장한 userId: \(String(describing: UserDefaults.standard.string(forKey: "loginSuccessId")))" )
                    
                    print("idPwInsertViewController")
                }
                case .failure(let error):
                print("응답 코드 :", response.response?.statusCode ?? 0)
                    print("에러",error.localizedDescription)
                break
            }
            
        }
    }
}
