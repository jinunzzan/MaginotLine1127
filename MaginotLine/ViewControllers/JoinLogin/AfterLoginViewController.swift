//
//  AfterLoginViewController.swift
//  MaginotLine
//
//  Created by Eunchan Kim on 2022/12/02.
//

import UIKit

class AfterLoginViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    let loginService = LoginService.shared
    let picker = UIImagePickerController()
    
    @IBOutlet weak var profileImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.delegate = self
        
        
        if let sheetPresentationController = sheetPresentationController {
                sheetPresentationController.detents = [.medium()]
        }
        profileImage.image = UIImage(named: "profile")
        profileImage.backgroundColor = .white
        profileImage.contentMode = .scaleAspectFill
        profileImage.layer.cornerRadius = profileImage.frame.height/2
        profileImage.frame.height / 2
        profileImage.layer.borderWidth = 10
        profileImage.layer.borderColor = UIColor.systemPink.cgColor
        profileImage.layer.shadowOffset = CGSize(width:5, height: 5)
        profileImage.layer.shadowOpacity = 0.7
        profileImage.layer.shadowRadius = 5
        profileImage.layer.shadowColor = UIColor.gray.cgColor
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else {return}
        profileImage.image = image
        dismiss(animated: true)
    }
    
    @IBAction func modifyProfile(_ sender: Any) {
        let alert = UIAlertController(title: "프로필 사진 설정" ,message: "프로필 사진 설정", preferredStyle: .actionSheet)
        let library = UIAlertAction(title: "앨범에서 사진 선택", style: .default){ _ in
            self.openLibrary()
        }
        alert.addAction(library)
        let camera = UIAlertAction(title: "카메라", style: .default){ _ in
            self.openCamera()
        }
        alert.addAction(camera)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    @IBAction func logout(_ sender: Any) {
        loginService.logout()
        self.dismiss(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func openLibrary() {
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }
    func openCamera() {
        if(UIImagePickerController .isSourceTypeAvailable(.camera)){
            picker.sourceType = .camera
            present(picker,animated: true, completion: nil)
        } else {
            print("Camera not Available")
        }
    }

}

