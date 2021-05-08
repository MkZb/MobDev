//
//  DrawingBooksController.swift
//  MobDev
//
//  Created by Mykola Zubets on 24.04.2021.
//

import UIKit

extension UITableView {
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }

    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

class Book: Decodable{
    var title: String
    var subtitle: String?
    var authors: String?
    var publisher: String?
    var isbn13: Int64?
    var pages: Int?
    var year: Int?
    var rating: Int?
    var desc: String?
    var price: Float?
    var image: UIImage?
    
    enum CodingKeys: String, CodingKey {
        case title
        case subtitle
        case authors
        case publisher
        case isbn13
        case pages
        case year
        case rating
        case desc
        case price
        case image
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.subtitle = try? container.decode(String.self, forKey: .subtitle)
        self.authors = try? container.decode(String.self, forKey: .authors)
        self.publisher = try? container.decode(String.self, forKey: .publisher)
        if let isbn13 = try? container.decode(String.self, forKey: .isbn13) {
            self.isbn13 = Int64(isbn13)
        } else {
            self.isbn13 = nil
        }
        if let pages = try? container.decode(String.self, forKey: .pages) {
            self.pages = Int(pages)
        } else {
            self.pages = nil
        }
        if let year = try? container.decode(String.self, forKey: .year) {
            self.year = Int(year)
        } else {
            self.year = nil
        }
        if let rating = try? container.decode(String.self, forKey: .rating) {
            self.rating = Int(rating)
        } else {
            self.rating = nil
        }
        self.desc = try? container.decode(String.self, forKey: .desc)
        if let price = try? container.decode(String.self, forKey: .price) {
            if price.range(of: #"\$[0-9]+\.[0-9]+"#, options: .regularExpression) != nil {
                self.price = Float(price.replacingOccurrences(of: "$", with: ""))
            } else {
                self.price = nil
            }
        }
        if let imgPath = try? container.decode(String.self, forKey: .image) {
            if imgPath != "" {
                self.image = UIImage(named: imgPath)
            } else {
                self.image = nil
            }
        } else {
            self.image = nil
        }
        
    }
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
        } else {
            self.image = nil
        }
    }
}

class DrawingBooksController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var books: [Book] = []
    var filteredBooks: [Book]!
    let cellIdentifier = "TableViewCell"
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
           case self.tableView:
            return self.filteredBooks.count
            default:
              return 0
           }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! TableViewCell
        var text: String = self.filteredBooks[indexPath.row].title + "\n\n"
        text += self.filteredBooks[indexPath.row].subtitle! + "\n\n"
        if let price = self.filteredBooks[indexPath.row].price {
            text += String(format: "$%.2f", price)
        } else {
            text += "Priceless"
        }
        cell.cellLabel?.text = text
        if let img = self.filteredBooks[indexPath.row].image{
            cell.cellPic?.image = img
            cell.cellPic?.contentMode = .scaleAspectFit
        } else {
            cell.cellPic?.image = nil
        }
          return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            performSegue(withIdentifier: "bookDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? BookDetailViewController {
            destination.bookInfo = self.books[(tableView.indexPathForSelectedRow?.row)!]
            self.tableView.deselectRow(at: tableView.indexPathForSelectedRow!, animated: true)
        }
    }
    
    @IBAction func done(segue:UIStoryboardSegue) {
       let bookAddVC = segue.source as! BookAddViewController
        if let book = bookAddVC.book {
            self.books.append(book)
            self.filteredBooks = books
        }
        self.tableView.reloadData()
    }
    
    @IBAction func cancel(segue:UIStoryboardSegue) {
      
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.books = parseBooks(path: "BooksList")!
        self.tableView.delegate = self
        self.searchBar.delegate = self
        self.tableView.dataSource = self
        self.tableView.estimatedRowHeight = 150.0
        self.tableView.rowHeight = UITableView.automaticDimension
        self.filteredBooks = books
        self.hideKeyboardWhenTappedAround()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.filteredBooks = searchText.isEmpty ? books : books.filter { (item: Book) -> Bool in
            return item.title.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        if self.filteredBooks.count == 0 {
            self.tableView.setEmptyMessage("No Books Found")
        } else {
            self.tableView.restore()
        }
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.books.remove(at: indexPath.row)
            self.filteredBooks.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    
    private func parseBooks(path: String) -> [Book]? {
        var bookList: [Book] = []
        if let path = Bundle.main.path(forResource: path, ofType: "txt") {
            do {
                  let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                  let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                  if let jsonResult = jsonResult as? Dictionary<String, AnyObject>, let books = jsonResult["books"] as? [Dictionary<String, AnyObject>] {
                    for book in books {
                        if let bookPath = Bundle.main.path(forResource:book["isbn13"] as? String, ofType: "txt") {
                            do {
                                let bookData = try Data(contentsOf: URL(fileURLWithPath: bookPath), options: .mappedIfSafe)
                                let parsedBook: Book = try! JSONDecoder().decode(Book.self, from: bookData)
                                bookList.append(parsedBook)
                            } catch {
                                print("Something wrong")
                            }
                        } else {
                            bookList.append(Book(title: book["title"] as! String, subtitle: book["subtitle"] as! String, isbn13: book["isbn13"] as! String, price: book["price"] as! String, image: book["image"] as!     String))
                            
                        }
                        
                    }
                    return bookList
                  }
              } catch {
                   print("Error Parsing")
              }
        }
        return nil
    }
}
