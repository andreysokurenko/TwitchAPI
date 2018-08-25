 //
//  Game.swift
//  TwitchApi
//
//  Created by Admin on 24.08.18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
 
 class Game {
    
    var gameName: String!
    var gameImageUrl: String!
    var gameImage: UIImage?
    
    init(name: String, imageUrl: String) {
        self.gameName = name
        self.gameImageUrl = imageUrl
    }
    
    func downloadGameImage(completed: @escaping downLoadComplete) {
        request(self.gameImageUrl).responseData { (response) in
            if let data = response.result.value {
                if let image = UIImage(data: data) {
                    self.gameImage = image
                }
            }
            completed()
        }
    }
    
    
 }
