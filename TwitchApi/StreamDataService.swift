//
//  StreamDataService.swift
//  TwitchApi
//
//  Created by Admin on 25.08.18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
import Alamofire

class StreamDataService {
    static let instance = StreamDataService()
    
    var streams = [Stream]()
    
    
    
    
    
    
    
    func downloadStreamForGame(_ game: Game, completed: @escaping downLoadComplete)  {
        
        // GET strems
        
        let gameString = game.gameName.replacingOccurrences(of: " ", with: "+")
        
        let url = TWITCH_URL_STREAM_BASE + gameString + twitchId
        
        var viewersCountDouble: Double!
        var imageUrlString: String!
        var nameString: String!
        var titleString: String!

        
        
        request(url).responseJSON { (response) in
            if let JSON = response.result.value as? [String: Any] {
                if let streamsArray = JSON["streams"] as? [Dictionary<String, Any>], streamsArray.count > 0 {
                    for i in 0..<streamsArray.count {
                        if let viewersCount = streamsArray[i]["viewers"] as? Double {
                            viewersCountDouble = viewersCount
                        }
                        if let imageDict = streamsArray[i]["preview"] as? [String: Any] {
                            if let imageUrl = imageDict["large"] as? String {
                                imageUrlString = imageUrl
                            }
                        }
                        if let channelDict = streamsArray[i]["channel"] as? [String: Any] {
                            if let name = channelDict["display_name"] as? String {
                                nameString = name
                            }
                            if let title = channelDict["status"] as? String {
                                titleString = title
                                
                            }
                        }
                        let stream = Stream(name: nameString, title: titleString, viewerCount: viewersCountDouble, imageUrl: imageUrlString)
                        self.streams.append(stream)
                    }
                }
            }
            completed()
        }
        
    }
    
    func removeAllStreams() {
        streams.removeAll()
    }
    
    
    
}
