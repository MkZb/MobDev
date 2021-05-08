//
//  CollectionsViewController.swift
//  MobDev
//
//  Created by Mykola Zubets on 08.05.2021.
//

import UIKit

class CollectionsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    private let cellIdentifier = "collectionCell"
    var dataArray: [UIImage] = []
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? CustomCollectionViewCell else {
            fatalError("Unable to dequeue CustomCollectionViewCell")
        }
        
        cell.imageView.clipsToBounds = true
        cell.imageView.contentMode = .scaleAspectFill
        cell.imageView.image = dataArray[indexPath.row]
        return cell
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else {
            return
        }
        // Add the image to the array
        dataArray.append(image)
        picker.dismiss(animated: true) { () -> Void in
        // Refresh the interface
            self.collectionView?.reloadData()
        }
    }
     
    // cancel
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // delete image selector
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addImageAction))
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    // add pictures
    @objc func addImageAction() {
        let picker: UIImagePickerController = UIImagePickerController()
        picker.delegate = self
        present(picker, animated: true)
    }
}

