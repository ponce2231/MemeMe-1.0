//
//  DetailsViewController.swift
//  Mememe 1.0
//
//  Created by Christopher Ponce Mendez on 7/28/19.
//  Copyright © 2019 none. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    @IBOutlet weak var detailsImageView: UIImageView!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = true
    }
    
}
