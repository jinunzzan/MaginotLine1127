//
//  CommunityPostWriteViewController.swift
//  MaginotLine
//
//  Created by Eunchan Kim on 2022/11/27.
//

import UIKit

class CommunityPostWriteViewController: UIViewController, UITextViewDelegate {
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var placeHolderLabel: UILabel!
    
    let textViewPlaceHolder = "지각러님의 이야기를 들려주세요."
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.delegate = self
        textView.textContainer.maximumNumberOfLines = 0
        textView.textContainer.lineFragmentPadding = 0
        
    }
    
    func textViewDidChange(_ textView:UITextView){
            if textView.text == "" {
                placeHolderLabel.isHidden = false
            } else {
                placeHolderLabel.isHidden = true
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
