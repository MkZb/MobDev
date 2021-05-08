//
//  BookDetailViewController.swift
//  MobDev
//
//  Created by Mykola Zubets on 08.05.2021.
//

import UIKit

class BookDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    let cellIdentifier = "bookInfo"
    var bookInfo: Book?
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! bookInfoCell
        
        cell.cellPic?.image = bookInfo!.image
        var text = ""
        text += "Title: " + bookInfo!.title + "\n"
        if let sub = bookInfo!.subtitle {
            text += "Subtitle: " + sub + "\n"
        } else {
            text += "Subtitle: -\n"
        }
        if let authors = bookInfo!.authors {
            text += "Authors: " + authors + "\n"
        } else {
            text += "Authors: -\n"
        }
        if let publisher = bookInfo!.publisher {
            text += "Publisher: " + publisher + "\n"
        } else {
            text += "Publisher: -\n"
        }
        if let year = bookInfo!.year {
            text += "Year: " + String(year) + "\n"
        } else {
            text += "Year: -\n"
        }
        if let pages = bookInfo!.pages {
            text += "Pages: " + String(pages) + "\n"
        } else {
            text += "Pages: -\n"
        }
        text += "\n"
        if let desc = bookInfo!.desc {
            text += "Description: " + desc + "\n"
        } else {
            text += "Description: -\n"
        }
        text += "\n"
        if let isbn13 = bookInfo!.isbn13 {
            text += "ISBN: " + String(isbn13) + "\n"
        } else {
            text += "ISBN: -\n"
        }
        if let price = bookInfo!.price {
            text += "Price: $" + String(format: "%.2f", price) + "\n"
        } else {
            text += "Price: -\n"
        }
        if let rating = bookInfo!.rating {
            text += "Rating: " + String(rating) + "/5\n"
        } else {
            text += "Rating: -/5\n"
        }
        cell.cellLabel?.text = text
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.estimatedRowHeight = 44.0
        self.tableView.rowHeight = UITableView.automaticDimension
    }
    
}
