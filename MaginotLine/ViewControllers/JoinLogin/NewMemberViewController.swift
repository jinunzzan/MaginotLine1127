//
//  NewMemberViewController.swift
//  MaginotLine
//
//  Created by 권지민 on 2022/11/25.
//

import UIKit

class NewMemberViewController: UIViewController {
    //half modalView
    override func viewDidLoad() {
        super.viewDidLoad()
        if let sheetPresentationController = sheetPresentationController {
            sheetPresentationController.detents = [.medium()]
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
}
