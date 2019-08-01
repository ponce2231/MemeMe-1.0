//
//  TableViewController.swift
//  Mememe 1.0
//
//  Created by Christopher Ponce Mendez on 7/16/19.
//  Copyright © 2019 none. All rights reserved.
//

import UIKit

class SentMemesTableViewController: UITableViewController {
private let reuseIdentifier = "SentMemesCell"
    


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //MARK: RELOADS THE TABLE WHEN CHANGED
        tableView!.reloadData()
    }
    // MARK: - Table view data source
    //DISPLAYS THE NUMBER OF ROWS
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataService.instance.getMemes().count
    }

    //DISPLAYS THE CONTENT OF THE CELL
   
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SentMemesTableViewCell
        let memeTableRow = DataService.instance.getMemes()[indexPath.row]

        cell.memeCellImage.image = memeTableRow.memedImage
        cell.detailLabel?.text = memeTableRow.topText + " " + memeTableRow.bottomText
        
        return cell
    }
    //CONTROLS THE HEIGHT OF THE ROW
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailsVC = storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController

        let memeTableRow = DataService.instance.getMemes()[indexPath.row]
        detailsVC.memeImage = memeTableRow.memedImage
        navigationController?.pushViewController(detailsVC, animated: true)
    }

}
