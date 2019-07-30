//
//  DataService.swift
//  Mememe 1.0
//
//  Created by Christopher Ponce Mendez on 7/30/19.
//  Copyright © 2019 none. All rights reserved.
//

import UIKit
class DataService {
    static let instance = DataService()
    
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    func getMemes() -> [Meme] {
        return memes
    }
    
}
