//
//  Stream.swift
//  TwitchApi
//
//  Created by Admin on 25.08.18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class Stream {
    
    var broadcasterName: String!
    var streamTitle: String!
    var streamViewerCount: Double!
    var streamImage: UIImage?
    var streamImageUrl: String!
    
    
    
    init(name: String, title: String, viewerCount: Double, imageUrl: String ) {
        self.broadcasterName = name
        self.streamTitle = title
        self.streamViewerCount = viewerCount
        self.streamImageUrl = imageUrl
    }
    
    func downloadStreamImage(completed: @escaping downLoadComplete) {
        request(self.streamImageUrl).responseData { (response) in
            if let data = response.result.value {
                if let image = UIImage(data: data) {
                    self.streamImage = image
                }
            }
            completed()
        }
    }
    
}

