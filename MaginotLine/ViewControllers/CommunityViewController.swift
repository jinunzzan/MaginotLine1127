//
//  CommunityViewController.swift
//  MaginotLine
//
//  Created by 권지민 on 2022/11/25.
//

import UIKit

class CommunityViewController: UIViewController {


    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    

}
extension CommunityViewController:UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "communityCell", for: indexPath)
        
        let communityName = cell.viewWithTag(12) as? UILabel
        
        communityName?.text = "n호선"
        
        cell.layer.cornerRadius = 20
        return cell
        
    }
}
extension CommunityViewController:UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSpace:CGFloat = 2
        let width = (collectionView.frame.width - 5 - itemSpace) / 2
        return CGSize(width: width, height: width * 1.2)
    }
}
