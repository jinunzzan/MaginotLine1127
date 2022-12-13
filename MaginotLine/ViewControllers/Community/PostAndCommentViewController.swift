//
//  PostAndCommentViewController.swift
//  MaginotLine
//
//  Created by Eunchan Kim on 2022/12/02.
//

import UIKit
import Alamofire

class PostAndCommentViewController: UIViewController {
    
    let loginSerivce = LoginService.shared
    var postComment:[PostComment] = []
    var boardPost:[BoardPost] = []
    
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblNickName: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblPost: UILabel!
    
    @IBOutlet weak var tfComment: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 프로토콜
        tableView.delegate = self
        tableView.dataSource = self
        
        // 게시글 표시
        lblNickName.text = boardPost.first?.member_nick
        lblPost.text = boardPost.first?.post_content
        lblDate.text = boardPost.first?.post_date
        
        // 댓글 표시하기
        getPostCommentList(post_num: boardPost.first?.post_num ?? 1)
        
        //키보드 올라가기 내려가기
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    //키보드 올라가기 내려가기
    @objc
    func keyboardWillShow(_ sender: Notification) {
        //        self.view.frame.origin.y = -330 // Move view 150 points upward
        if let keyboardFrame: NSValue = sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            self.view.frame.origin.y = -keyboardHeight
        }
    }
    
    @objc
    func keyboardWillHide(_ sender: Notification) {
        self.view.frame.origin.y = 0 // Move view to original position
    }
    
    @IBAction func commentSubmit(_ sender: Any) {
        
        if !loginSerivce.checkLogin(){
            loginModalView()
        } else {
            commentWrite()
            //            getPostCommentList(post_num: boardPost.first?.post_num ?? 1)
        }
        // 댓글 단 후 tf 초기화
        tfComment.text = ""
        tfComment.resignFirstResponder()
        
    }
    // 로그아웃 상태시 로그인 모달 띄우기
    func loginModalView(){
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "LoginModalViewController") as! LoginModalViewController
        present(vc, animated: true, completion: nil)
    }
    // 댓글 .get
    func getPostCommentList(post_num:Int){
        let str = "\(url)/post_comment/\(post_num)"
        AF.request(str, method: .get).responseDecodable(of: [PostComment].self) { response in
            print("response: \(response)")
            guard let res = response.value
            else {return}
            
            self.postComment = res
            print("댓글!!!!! \(self.postComment)")
            self.tableView.reloadData()
        }
    }
    
    // 댓글 쓰기
    func commentWrite(){
        guard let commentContent = tfComment.text, !commentContent.isEmpty else { return }
        guard let memberNick = UserDefaults.standard.string(forKey: Constant.loginNick) else {return}
        
        let params: Parameters = [
            "post_num" : boardPost.first?.post_num as Any,
            "member_nick" : memberNick,
            "comment_content" : commentContent
        ]
        let commentUrl = "\(url)/post_comment"
        AF.request(
            commentUrl,
            method: .post,
            parameters: params,
            encoding: JSONEncoding.default)
        .responseData{ response in
            switch response.result {
            case.success(let res):
                do {
                    print("댓글달기", String(data:res, encoding: .utf8) ?? "")
                    //                    self.getPostCommentList(post_num: self.boardPost.first?.post_num ?? 1)
                    let newComment = PostComment(post_num: self.boardPost.first?.post_num, member_nick: memberNick, comment_content: commentContent)
                    self.postComment.append(newComment)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            case.failure(let err):
                print("응답코드 : ", response.response?.statusCode ?? 0)
                print("에러 : ", err.localizedDescription)
                break
            }
        }
    }
    
}
extension PostAndCommentViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postComment.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath)
        let comment = postComment[indexPath.row]
        let lblCommentNick = cell.viewWithTag(2) as? UILabel
        lblCommentNick?.text = comment.member_nick
        let lblCommentContent = cell.viewWithTag(3) as? UILabel
        lblCommentContent?.text = comment.comment_content
        
        
        return cell
    }
    
    
}
