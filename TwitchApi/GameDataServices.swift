//
//  GameDataServices.swift
//  TwitchApi
//
//  Created by Admin on 24.08.18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
import Alamofire

class GameDataServices {
    
    static let instance = GameDataServices()
    
    var games = [Game]()
    var nameString: String!
    var imageUrlString: String!
    
    
    func downloadTopGames(completed: @escaping downLoadComplete) {
     
        let url = TWITCH_URLTOP_GAMES
        
        request(url).responseJSON { (response) in
            print(response)
            
            if let JSON = response.result.value as? [String: Any] {
                
                if let topGamesArray = JSON["top"] as? [[String: Any]], topGamesArray.count > 0  {
                    for i in 0..<topGamesArray.count {
                        
                        if let gameDict = topGamesArray[i]["game"] as? [String: Any] {
                            
                            if let gameName = gameDict["name"] as? String {
                                self.nameString = gameName
                            }
                            
                            if let boxArt = gameDict["box"] as? [String: Any] {
                                if let imageUrl = boxArt["large"] as? String {
                                    self.imageUrlString = imageUrl
                                }
                                
                            }
                        }
                        let game = Game(name: self.nameString, imageUrl: self.imageUrlString)
                        self.games.append(game)
                    }
                }
            }
            completed()
        }
        
        
    }
    
    
}
