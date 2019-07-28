//
//  SentMemesTableViewCell.swift
//  Mememe 1.0
//
//  Created by Christopher Ponce Mendez on 7/24/19.
//  Copyright © 2019 none. All rights reserved.
//

import UIKit

class SentMemesTableViewCell: UITableViewCell {
   //SHARED MODEL MEME
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    //MARK: OUTLETS
    @IBOutlet weak var memeCellImage: UIImageView!
    @IBOutlet weak var detailLabel: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
