//
//  LoginModalViewController.swift
//  MaginotLine
//
//  Created by Eunchan Kim on 2022/11/24.
//

import UIKit

class LoginModalViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //half modalView
        if let sheetPresentationController = sheetPresentationController {
                    sheetPresentationController.detents = [.medium()]
                }
        profileImage.backgroundColor = .white
        profileImage.contentMode = .scaleAspectFill
        profileImage.layer.cornerRadius =  profileImage.frame.height / 2
        profileImage.layer.borderWidth = 12
        profileImage.layer.borderColor = UIColor.systemPink.cgColor
        profileImage.layer.shadowOffset = CGSize(width:5, height: 5)
        profileImage.layer.shadowOpacity = 0.7
        profileImage.layer.shadowRadius = 5
        profileImage.layer.shadowColor = UIColor.gray.cgColor
        
//
//        UserDefaults.standard.set(loginSuccess, forKey: "loginSuccessId")

        if loginSuccess.isEmpty {
            print("값이 없음")
           
            guard let id = UserDefaults.standard.string(forKey: "loginSuccessId") else { return }
            
//            let id = UserDefaults.standard.string(forKey: "loginSuccessId")
            print("유저디폴트에 저장한 변수 id = \(String(describing: id))")
        } else {
            print("LoginModalViewController")
            print(loginSuccess)
            print("=================")
//            print(UserDefaults.standard.string(forKey: "loginSuccessId") ?? "")
//
        }

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
