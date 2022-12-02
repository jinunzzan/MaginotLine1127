//
//  PostAndCommentViewController.swift
//  MaginotLine
//
//  Created by Eunchan Kim on 2022/12/02.
//

import UIKit
import Alamofire

class PostAndCommentViewController: UIViewController {
    
    var postComment:[PostComment] = []
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblNickName: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblPost: UILabel!
    
    @IBOutlet weak var tfComment: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
      
    }
    
    func getPostCommentList(post_num:Int){
        let str = "\(url)/post_comment/\(post_num)"
        AF.request(str, method: .get)
            .responseDecodable(of:[postComment].self){
                response in print("response: \(response)")
                guard let res = response.value else {return}
                
                self.boardPosts = res
                print("나는야 댓글이야 \(self.postComment)")
                self.tableView.reloadData()
            }
    }

}
extension PostAndCommentViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postComment.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath)
        
        return 1
    }
    
    
}
