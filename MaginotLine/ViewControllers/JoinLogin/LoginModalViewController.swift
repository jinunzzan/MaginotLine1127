//
//  LoginModalViewController.swift
//  MaginotLine
//
//  Created by Eunchan Kim on 2022/11/24.
//

import UIKit
import AuthenticationServices

class LoginModalViewController: UIViewController {
    
    let loginService = LoginService.shared
    
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var joinProfileBtn: UIButton!
    
    @IBOutlet weak var loginLogoutBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //half modalView
        if let sheetPresentationController = sheetPresentationController {
            sheetPresentationController.detents = [.medium()]
        }
        profileImage.image = UIImage(named: "profile")
        profileImage.backgroundColor = .white
        profileImage.contentMode = .scaleAspectFill
        profileImage.layer.cornerRadius =  profileImage.frame.height / 2
        profileImage.frame.height / 2
        profileImage.layer.borderWidth = 10
        profileImage.layer.borderColor = UIColor.systemPink.cgColor
        profileImage.layer.shadowOffset = CGSize(width:5, height: 5)
        profileImage.layer.shadowOpacity = 0.7
        profileImage.layer.shadowRadius = 5
        profileImage.layer.shadowColor = UIColor.gray.cgColor
        
        
        if loginService.checkLogin() == true {
            self.dismiss(animated: true)
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as? IdPwInsertViewController
        vc?.beforeVC = self
    }
    
    
    
}

