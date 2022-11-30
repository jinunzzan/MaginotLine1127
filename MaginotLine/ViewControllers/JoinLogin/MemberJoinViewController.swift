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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction func cancleBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func joinBtn(_ sender: Any) {
        join()
// 회원가입 성공시 화면은 로그인 화면으로 이동한다.
        
        
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
