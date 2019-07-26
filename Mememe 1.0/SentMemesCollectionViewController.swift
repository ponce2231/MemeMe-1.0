//
//  CollectionViewController.swift
//  Mememe 1.0
//
//  Created by Christopher Ponce Mendez on 7/16/19.
//  Copyright © 2019 none. All rights reserved.
//

import UIKit
import Foundation

//private let reuseIdentifier = "Cell"

class SentMemesCollectionViewController: UICollectionViewController {
    
        @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let space: CGFloat = 3.0
        let dimension = (view.frame.size.width - (3 * space)) / 3.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
        print(dimension)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
//        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        collectionView!.reloadData()
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.memes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SentMemesViewCell", for: indexPath) as! MemesCollectionViewCell
        let meme = self.memes[indexPath.row]
        
        cell.memeImageView.image = meme.memedImage
    
        return cell
    }

}
