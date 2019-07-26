//
//  TableViewController.swift
//  Mememe 1.0
//
//  Created by Christopher Ponce Mendez on 7/16/19.
//  Copyright © 2019 none. All rights reserved.
//

import UIKit

class SentMemesTableViewController: UITableViewController{

    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        
//    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView!.reloadData()
    }
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SentMemesCell", for: indexPath) as! SentMemesTableViewCell
        let memeTableRow =  memes[indexPath.row]
        
        cell.memeCellImage.image = memeTableRow.memedImage
        cell.detailLabel?.text = memeTableRow.topText + memeTableRow.bottomText
        
        return cell
    }

}
