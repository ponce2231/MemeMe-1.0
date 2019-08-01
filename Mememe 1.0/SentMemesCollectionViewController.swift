//
//  CollectionViewController.swift
//  Mememe 1.0
//
//  Created by Christopher Ponce Mendez on 7/16/19.
//  Copyright © 2019 none. All rights reserved.
//

import UIKit
import Foundation

private let reuseIdentifier = "SentMemesViewCell"

class SentMemesCollectionViewController: UICollectionViewController {
    
        @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
//    let meme = DataService.instance.getMemes()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let space: CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0
        //ACOMODATES THE CONTENT OF THE VIEW COLLECTION
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView!.reloadData()
    }


    // MARK: UICollectionViewDataSource
//DISPLAYS HOW MANY ITEMS ARE
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return memes.count
    }
//DISPLAYS THE CONTENT OF THE CELL
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MemesCollectionViewCell
       let meme = memes[indexPath.row]
        cell.memeImageView.image = meme.memedImage
    
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailsVC = storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        let memeTableRow = memes[indexPath.row]
        detailsVC.memeImage = memeTableRow.memedImage
        navigationController?.pushViewController(detailsVC, animated: true)

    }
    
    

}
