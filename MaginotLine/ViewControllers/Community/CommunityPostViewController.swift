//
//  CommunityPostViewController.swift
//  MaginotLine
//
//  Created by 권지민 on 2022/11/26.
//

import UIKit
import Alamofire

class CommunityPostViewController: UIViewController, UIScrollViewDelegate {
    
    let loginService = LoginService.shared
    @IBOutlet weak var fixedImage: UIImageView!
    @IBOutlet weak var lblBoard: UILabel!
    
    var board:Community?
    
    var boardPosts:[BoardPost] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var fixHeaderHeight: NSLayoutConstraint!
    let MaxTopHeight:CGFloat = 270
    let MinTopHeight:CGFloat = 50 + UIApplication.shared.statusBarFrame.height
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        getBoardPostList(boardNum: board?.boardNum ?? 1)
        
        view.addSubview(floatingButton)
        setFloatingButton()
        if let board = board {
            fixedImage.image = UIImage(named: board.boardImg)
            lblBoard.text = board.boardName
        }
        
        
    }
    // 게시글 get 해오기!
    func getBoardPostList(boardNum:Int){
        let str = "\(url)/board_post/\(board?.boardNum ?? 1)"
        AF.request(str, method: .get)
            .responseDecodable(of:[BoardPost].self){
                response in
                print("response: \(response)")
                guard let res = response.value else {return}
                
                self.boardPosts = res
                print("나는야 보드 포스트 \(self.boardPosts)")
                self.collectionView.reloadData()
                
            }
    }
    
    //글쓰기 버튼
    lazy var floatingButton: UIButton = {
        let button = UIButton(type: .system)
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 45, weight: .light)
        let image = UIImage(systemName: "pencil.circle.fill", withConfiguration: imageConfig)
        button.setImage(image, for: .normal)
        button.tintColor = UIColor(named: "MaginotLineColor")
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("", for: .normal)
        button.addTarget(self, action: #selector(ClickedBtn), for: .touchUpInside)
        
        return button
    }()
    //floatingButton 위치 조정
    func setFloatingButton(){
        view.addConstraint(NSLayoutConstraint(item: floatingButton, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: -40))
        view.addConstraint(NSLayoutConstraint(item: floatingButton, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: -32))
        
    }
    // flotingButton 클릭시 modalView
    func BtnFunc(){
        floatingButton.addTarget(self, action: #selector(self.ClickedBtn), for: .touchUpInside)
        
    }
    //새로고침
    func refresh(value: BoardPost){
        self.boardPosts.append(value)
        collectionView.reloadData()
    }
    @objc func ClickedBtn(sender: UIButton!){
        
        //로그인 유무 확인하기
        if !loginService.checkLogin(){
            loginModalView()
        } else {
            let sb = UIStoryboard(name: "Main", bundle: nil)
            guard let vc = sb.instantiateViewController(withIdentifier: "CommunityPostWriteViewController") as? CommunityPostWriteViewController,
                  let board = self.board else { return }
            vc.boardNumber = board.boardNum
    //        vc.beforeVC = self
    //
            
            present(vc, animated: true, completion: nil)
            print("버튼 클릭")
        }
    }
    // 로그아웃 상태시 로그인 모달 띄우기
    func loginModalView(){
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "LoginModalViewController") as! LoginModalViewController
        present(vc, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // 글 입력 할 때 보드 넘버 보내기
        let vc = segue.destination as? CommunityPostWriteViewController
        let indexPaths = collectionView.indexPathsForSelectedItems
        guard let indexPath = indexPaths?.first else { return }
        let community = communities[indexPath.row]
        vc?.board = community
        
        // 댓글 입력창에 글 내용 보내기
        let vc2 = segue.destination as? PostAndCommentViewController
        let boardPost = boardPosts[indexPath.row]
        vc2?.boardPost = [boardPost]
        

    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        //현재 스크롤의 위치 (최상단 = 0)
        let y: CGFloat = scrollView.contentOffset.y
        
        //변경될 최상단 뷰의 높이
        let ModifiedTopHeight: CGFloat = fixHeaderHeight.constant - y
        
        // *** 변경될 높이가 최댓값을 초과함
        if(ModifiedTopHeight > MaxTopHeight)
        {
            //현재 최상단뷰의 높이를 최댓값(270)으로 설정
            fixHeaderHeight.constant = MaxTopHeight
        }// *** 변경될 높이가 최솟값 미만임
        else if(ModifiedTopHeight < MinTopHeight)
        {
            //현재 최상단뷰의 높이를 최솟값(50+상태바높이)으로 설정
            fixHeaderHeight.constant = MinTopHeight
        }// *** 변경될 높이가 최솟값(50+상태바높이)과 최댓값(250) 사이임
        else
        {
            //현재 최상단 뷰 높이를 변경함
            fixHeaderHeight.constant = ModifiedTopHeight
            scrollView.contentOffset.y = 0
        }
        
        
    }
}
extension CommunityPostViewController:UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return boardPosts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("indexPath.row : \(indexPath.row)")
        let boardPost = boardPosts[indexPath.row]
        print("boardPost입니다: \(boardPost))")
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "postCell", for: indexPath)
        cell.layer.cornerRadius = 20
        
        let postNick =  cell.viewWithTag(1) as? UILabel
        postNick?.text = boardPost.member_nick
        
        let postContent = cell.viewWithTag(2) as? UILabel
        postContent?.text = boardPost.post_content
        
        return cell
    }
    
    
}
extension CommunityPostViewController:UICollectionViewDelegate {
    
}
extension CommunityPostViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
