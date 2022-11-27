//
//  CommunityPostViewController.swift
//  MaginotLine
//
//  Created by 권지민 on 2022/11/26.
//

import UIKit

class CommunityPostViewController: UIViewController, UIScrollViewDelegate {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var fixHeaderHeight: NSLayoutConstraint!
    let MaxTopHeight:CGFloat = 270
    let MinTopHeight:CGFloat = 50 + UIApplication.shared.statusBarFrame.height
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        
        view.addSubview(floatingButton)
       setFloatingButton()
       
    }
    
    //글쓰기 버튼
    lazy var floatingButton: UIButton = {
           let button = UIButton(type: .system)
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .light)
        let image = UIImage(systemName: "pencil.circle.fill", withConfiguration: imageConfig)
        button.setImage(image, for: .normal)
        button.tintColor = .systemPink
        
        button.translatesAutoresizingMaskIntoConstraints = false
           button.setTitle("", for: .normal)
        button.addTarget(self, action: #selector(ClickedBtn), for: .touchUpInside)
       
           return button
       }()
    //floatingButton 위치 조정
    func setFloatingButton(){
        view.addConstraint(NSLayoutConstraint(item: floatingButton, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: -80))
        view.addConstraint(NSLayoutConstraint(item: floatingButton, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: -32))
           
    }
    // flotingButton 클릭시 modalView
    func BtnFunc(){
        floatingButton.addTarget(self, action: #selector(self.ClickedBtn), for: .touchUpInside)
       
    }
    @objc func ClickedBtn(sender: UIButton!){
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "CommunityPostWriteViewController") as! CommunityPostWriteViewController
        
       
            present(vc, animated: true, completion: nil)
            print("버튼 클릭")
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
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "postCell", for: indexPath)
        cell.layer.cornerRadius = 20
        return cell
    }
    
    
}
extension CommunityPostViewController:UICollectionViewDelegate {
    
}
