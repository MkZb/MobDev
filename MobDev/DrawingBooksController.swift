//
//  DrawingBooksController.swift
//  MobDev
//
//  Created by Mykola Zubets on 24.04.2021.
//

import UIKit

class DrawingBooksController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    var books: [Book] = []
    let cellIdentifier = "TableViewCell"
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
           case self.tableView:
            return self.books.count
            default:
              return 0
           }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! TableViewCell
        var text: String = self.books[indexPath.row].title! + "\n\n"
        text += self.books[indexPath.row].subtitle! + "\n\n"
        if let price = self.books[indexPath.row].price {
            text += String(format: "$%.2f", price)
        } else {
            text += "Priceless"
        }
        cell.cellLabel?.text = text
        if let img = self.books[indexPath.row].image{
            cell.cellPic?.image = img
            cell.cellPic?.contentMode = .scaleAspectFit
        } else {
            cell.cellPic?.image = nil
        }
          return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.books = parseBooks(path: "BooksList")!
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.estimatedRowHeight = 44.0
        self.tableView.rowHeight = UITableView.automaticDimension
    }
    
    private func parseBooks(path: String) -> [Book]? {
        var bookList: [Book] = []
        if let path = Bundle.main.path(forResource: path, ofType: "txt") {
            do {
                  let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                  let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                  if let jsonResult = jsonResult as? Dictionary<String, AnyObject>, let books = jsonResult["books"] as? [Dictionary<String, AnyObject>] {
                    for book in books {
                        bookList.append(Book(title: book["title"] as! String, subtitle: book["subtitle"] as! String, isbn13: book["isbn13"] as! String, price: book["price"] as! String, image: book["image"] as! String))
                        
                    }
                    return bookList
                  }
              } catch {
                   print("Error Parsing")
              }
        }
        return nil
    }
    
    class Book {
        var title: String?
        var subtitle: String?
        var isbn13: Int64?
        var price: Float?
        var image: UIImage?
        
        init(title: String, subtitle: String, isbn13: String, price: String, image: String) {
            
            self.title = title
            self.subtitle = subtitle
            if isbn13.range(of: #"[0-9]+"#, options: .regularExpression) != nil {
                self.isbn13 = Int64(isbn13)
            } else {
                self.isbn13 = nil
            }
            if price.range(of: #"\$[0-9]+\.[0-9]+"#, options: .regularExpression) != nil {
                self.price = Float(price.replacingOccurrences(of: "$", with: ""))
            } else {
                self.price = nil
            }
            if image != "" {
                self.image = UIImage(named: image)
            }
        }
    }
}
