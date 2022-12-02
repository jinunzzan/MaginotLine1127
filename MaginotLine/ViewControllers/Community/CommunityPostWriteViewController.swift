//
//  CommunityPostWriteViewController.swift
//  MaginotLine
//
//  Created by Eunchan Kim on 2022/11/27.
//

import UIKit
import Alamofire

class CommunityPostWriteViewController: UIViewController, UITextViewDelegate {
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var placeHolderLabel: UILabel!
    
    
    var board: Community?
    var memberInfo : MemberInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.delegate = self
        textView.textContainer.maximumNumberOfLines = 0
        textView.textContainer.lineFragmentPadding = 0
        
        self.textView.becomeFirstResponder()
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    // textViewPlaceholder
    func textViewDidChange(_ textView:UITextView){
        if textView.text == "" {
            placeHolderLabel.isHidden = false
        } else {
            placeHolderLabel.isHidden = true
        }
    }
    
    @IBAction func cancelBtn(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func postBtn(_ sender: Any) {
        post()
       dismiss(animated: true)
        
        
    }
    
    func post(){
        let boardNum = board?.boardNum
        guard let postContent = textView.text, !postContent.isEmpty else {fatalError()}
        guard let memberNick = UserDefaults.standard.string(forKey: Constant.loginNick) else {return}
        
        let params: Parameters = [
            "board_num" : boardNum ?? 10,
            "post_content" : postContent,
            "member_nick" : memberNick
        ]
        
        AF.request(
            postUrl,
            method: .post,
            parameters: params,
            encoding: JSONEncoding.default)
        .responseData{ response in
            switch response.result {
            case .success(let res):
                do{
                    print("글쓰기", String(data:res, encoding: .utf8) ?? "")
                }
            case .failure(let err):
                print("응답코드: ", response.response?
                    .statusCode ?? 0)
                print("에러::", err.localizedDescription)
                break
            }
        }
        
    }
}
