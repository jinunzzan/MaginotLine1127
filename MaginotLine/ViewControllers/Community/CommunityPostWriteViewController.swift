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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.delegate = self
        textView.textContainer.maximumNumberOfLines = 0
        textView.textContainer.lineFragmentPadding = 0
        
        self.textView.becomeFirstResponder()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    // textViewPlaceholder
    func textViewDidChange(_ textView:UITextView){
            if textView.text == "" {
                placeHolderLabel.isHidden = false
            } else {
                placeHolderLabel.isHidden = true
            }
        }
    
    @IBAction func cancelBtn(_ sender: Any) {
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
}
