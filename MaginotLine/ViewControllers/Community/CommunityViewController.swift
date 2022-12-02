//
//  CommunityViewController.swift
//  MaginotLine
//
//  Created by 권지민 on 2022/11/25.
//

import UIKit
import Alamofire

class CommunityViewController: UIViewController {
    
    //api 변수
    var boardPost: BoardPost?
    let loginService = LoginService.shared
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    @IBAction func checkLogin(_ sender: Any) {
        if loginService.checkLogin() == true {
            guard let afterLoginVC = self.storyboard?.instantiateViewController(identifier: "AfterLoginViewController") as? AfterLoginViewController else { return }
//            afterLoginVC.modalTransitionStyle = .coverVertical
//            afterLoginVC.modalPresentationStyle = .fullScreen
            if let sheet = afterLoginVC.sheetPresentationController {
                sheet.detents = [.medium()]
                sheet.prefersGrabberVisible = true
            }
            self.present(afterLoginVC, animated: true, completion:nil)
        } else {
            guard let beforeLoginVC = self.storyboard?.instantiateViewController(identifier: "LoginModalViewController") as? LoginModalViewController else { return }
//            beforeLoginVC.modalTransitionStyle = .coverVertical
//            beforeLoginVC.modalPresentationStyle = .fullScreen
            if let sheet = beforeLoginVC.sheetPresentationController {
                sheet.detents = [.medium()]
                sheet.prefersGrabberVisible = true
            }
            self.present(beforeLoginVC, animated: true, completion:nil)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as? CommunityPostViewController
        let indexPaths = collectionView.indexPathsForSelectedItems
        guard let indexPath = indexPaths?.first else { return }
        let community = communities[indexPath.row]
        vc?.board = community
    }
}





// 컬렉션뷰 그리기

extension CommunityViewController:UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "communityCell", for: indexPath)
        
        let community = communities[indexPath.row]
        
        let communityImg = cell.viewWithTag(1) as? UIImageView
        communityImg?.image = UIImage(named: community.boardImg)
        
        let communityName = cell.viewWithTag(2) as? UILabel
        communityName?.text = community.boardName
        
        cell.layer.cornerRadius = 20
        return cell
        
    }

}
extension CommunityViewController:UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let width = collectionView.frame.width
        let height = collectionView.frame.height
        let itemsPerRow: CGFloat = 2
        let widthPadding = sectionInsets.left * (itemsPerRow + 1)
        let itemsPerColumn: CGFloat = 3
        let heightPadding = sectionInsets.top * (itemsPerColumn + 1)
        let cellWidth = (width - 10) / itemsPerRow
        let cellHeight = (height - heightPadding) / itemsPerColumn
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    
}
