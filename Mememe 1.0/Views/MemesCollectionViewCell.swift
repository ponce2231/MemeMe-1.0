//
//  MemesCollectionViewCell.swift
//  Mememe 1.0
//
//  Created by Christopher Ponce Mendez on 7/24/19.
//  Copyright © 2019 none. All rights reserved.
//

import UIKit
import Foundation

class MemesCollectionViewCell: UICollectionViewCell {
    //MARK: OUTLETS
    @IBOutlet weak var memeImageView: UIImageView!
    //SHARED MODEL MEME 
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
//let meme = DataService.instance.getMemes()
}
