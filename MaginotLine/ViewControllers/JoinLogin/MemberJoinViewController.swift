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
        self.dismiss(animated: true)
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
                        }
                    case .failure(let err):
                        print("응답 코드 :", response.response?.statusCode ?? 0)
                        print("에러 ::", err.localizedDescription)
                        break
                    }
            }
        
    }

}
