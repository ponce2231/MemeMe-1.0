//
//  DetailsViewController.swift
//  Mememe 1.0
//
//  Created by Christopher Ponce Mendez on 7/28/19.
//  Copyright © 2019 none. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    var memeImage = UIImage()

    @IBOutlet weak var detailsImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailsImageView.image = memeImage
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        self.tabBarController?.tabBar.isHidden = false
    }
    
}
