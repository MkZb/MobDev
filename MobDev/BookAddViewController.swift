//
//  BookAddViewController.swift
//  MobDev
//
//  Created by Mykola Zubets on 08.05.2021.
//

import UIKit

class BookAddViewController: UIViewController, UIScrollViewDelegate{
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var subtitleField: UITextField!
    @IBOutlet weak var priceField: UITextField!
    
    var book: Book?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "doneSegue" {
            if let title = titleField.text, let sub = subtitleField.text, let price = priceField.text {
                if (title != "") && (sub != "") && (price.range(of: #"[0-9]+\.[0-9]+"#, options: .regularExpression) != nil) {
                    book = Book(title: title, subtitle: sub, isbn13: "", price: "$" + price, image: "")
                }
                else {
                    book = nil
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()

        NotificationCenter.default.addObserver(self, selector: #selector(BookAddViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(BookAddViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height , right: 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }

}
