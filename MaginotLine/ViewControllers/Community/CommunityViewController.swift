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

    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}




// 컬렉션뷰 그리기

extension CommunityViewController:UICollectionViewDataSource{
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "communityCell", for: indexPath)
     
        let keys = communities.keys.sorted()
        let key = keys[indexPath.section]
        guard let boardName = communities[key] else {fatalError()}
        
                let community = boardName[indexPath.row]
        
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
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSpace:CGFloat = 3
        let width: CGFloat = (UIScreen.main.bounds.width - itemSpace * 2)/3
        return CGSize(width: width, height: width * 1.2)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    
}
