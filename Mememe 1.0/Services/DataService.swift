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
    var memes = [Meme]()
    
    func getMemes() -> [Meme] {
        return memes
    }
    
}
